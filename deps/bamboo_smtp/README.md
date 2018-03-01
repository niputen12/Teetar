[![Build Status](https://travis-ci.org/fewlinesco/bamboo_smtp.svg?branch=master)](https://travis-ci.org/fewlinesco/bamboo_smtp)

# Bamboo.SMTPAdapter

An Adapter for the [Bamboo](https://github.com/thoughtbot/bamboo) email app.

## Installation

The package can be installed as:

1. Add `bamboo_smtp` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:bamboo_smtp, "~> 1.2.1"}]
  end
  ```

2. Add `bamboo` and `bamboo_smtp` to your list of applications in `mix.exs`:

  ```elixir
  def application do
    [applications: [:bamboo, :bamboo_smtp]]
  end
  ```

3. Setup your SMTP configuration:

  ```elixir
  # In your config/config.exs file
  config :my_app, MyApp.Mailer,
    adapter: Bamboo.SMTPAdapter,
    server: "smtp.domain",
    port: 1025,
    username: "your.name@your.domain",
    password: "pa55word",
    tls: :if_available, # can be `:always` or `:never`
    ssl: false, # can be `true`
    retries: 1
  ```

4. Follow Bamboo [Getting Started Guide](https://github.com/thoughtbot/bamboo#getting-started)

## Contributing

Before opening a pull request you can open an issue if you have any question or need some guidance.

Here's how to setup the project:

```
$ git clone https://github.com/fewlinesco/bamboo_smtp.git
$ cd bamboo_smtp
$ mix deps.get
$ mix test
```

Once you've made your additions and `mix test` passes, go ahead and open a Pull Request.

## License

Bamboo SMTPAdapter is released under [The MIT License (MIT)](https://opensource.org/licenses/MIT).
