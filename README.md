# Proxify

Proxify takes any Ruby class and creates a proxy that fronts that class. The class can declare messages that are allowed to be proxied through.

## Installation

Add this line to your application's Gemfile:

    gem 'proxify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install proxify

## Usage

Here `Foo` includes `Proxify::Me` and a list of messages that can be proxied through via the `proxy` function.

`hello`, `say` and `tell` are allowed to be called and are argument less, with arguments and with block examples.  `goodbye` is not proxied and will raise an `UndefinedMethod` error.

  class Foo
    include Proxify::Me

    proxy :hello, :say, :tell

    def hello
      "world"
    end

    def goodbye
      "world"
    end

    def say(something)
      something
    end

    def tell
      yield
    end

  end

To create the proxy, call the `proxify` method, this will return a `FooProxy` type.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
