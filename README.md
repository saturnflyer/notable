# Notable

:star2: Extraordinary insight into your users and background jobs

Wouldn’t it be great to see when one of your users encounters an error, timeout, or validation failure?  Now you can - directly in your admin pages.

#### Introducing Notable

Notable tracks notable requests and background jobs and stores them in your database.  What makes a request or job notable?  There are a number of default situations, but ultimately you decide what interests you.

By default, Notable tracks:

- errors
- 404s
- slow requests and jobs
- timeouts
- validation failures
- CSRF failures
- unpermitted parameters
- blocked and throttled requests

You can track custom notes as well.

:tangerine: Battle-tested at [Instacart](https://www.instacart.com/opensource)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'notable'
```

And run:

```sh
rails generate notable:requests
rails generate notable:jobs # optional
rake db:migrate
```

For a web interface, check out [Notable Web](https://github.com/ankane/notable_web).

## Requests

A `Notable::Request` is created for:

- errors
- 404s
- slow requests
- timeouts
- validation failures
- [CSRF failures](http://guides.rubyonrails.org/security.html#cross-site-request-forgery-csrf)
- unpermitted parameters
- blocked and throttled requests

For timeouts, use [Slowpoke](https://github.com/ankane/slowpoke).

For blocked and throttled requests, use [Rack Attack](https://github.com/kickstarter/rack-attack).

## Jobs

Wouldn’t it be great to have a record of exact jobs that fail?

A `Notable::Job` is created for:

- errors
- slow jobs
- validation failures

Currently works with Delayed Job and Sidekiq.

## Manual Tracking

```ruby
Notable.track(note_type, note)
```

Like

```ruby
Notable.track("Auth Event", "Signed In")
```

## Customize

Disable tracking in certain environments

```ruby
Notable.enabled = Rails.env.production?
```

### Requests

Set slow threshold

```ruby
Notable.slow_request_threshold = 5 # seconds (default)
```

Custom user method

```ruby
Notable.user_method = proc do |env|
  env["warden"].try(:user) || env["action_controller.instance"].try(:current_visit)
end
```

Custom track method

```ruby
Notable.track_request_method = proc do |data, env|
  Notable::Request.create!(data)
end
```

Skip tracking CSRF failures

```ruby
skip_before_filter :track_unverified_request
```

Custom request storage

Notable is built to store request details with [RequestStore](https://github.com/steveklabnik/request_store). If you want to change the way it stores information to an alternative like [RequestLocals](https://github.com/ElMassimo/request_store_rails) you may change the default

```ruby
Notable.request_store = RequestLocals
```

You may need to update your rack middleware accordingly

```ruby
app.config.middleware.insert_after RequestStoreRails::Middleware, Notable::Middleware
```

### Jobs

Set slow threshold

```ruby
Notable.slow_job_threshold = 60 # seconds (default)
```

Custom track method

```ruby
Notable.track_job_method = proc do |data|
  Notable::Job.create!(data)
end
```

## TODO

- ability to disable features
- add indexes

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/notable/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/notable/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
