[![Build Status](https://travis-ci.org/davidjuin0519/rubidux.svg?branch=master)](https://travis-ci.org/davidjuin0519/rubidux.svg?branch=master)

# Rubidux

Rubidux is a tiny state management library inspired by [Redux](https://github.com/reactjs/redux)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubidux'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubidux

## Usage

### Rubidux::Reducer
Reducers are functions that take state and action as arguments and return a new state. So you can have a reducer like this:

```ruby
r1 = -> (state, action) {
  state ||= { a: 0, b: 0 }

  case action[:type]
  when 'a_plus_one'
    { a: state[:a]+1, b: state[:b] }
  when 'b_plus_one'
    { a: state[:a], b: state[:b]+1 }
  else
    state
  end
}

r2 = -> (state, action) {
  state ||= { c: 0, d: 0 }

  case action[:type]
  when 'c_plus_one'
    { c: state[:c]+1, d: state[:d] }
  when 'd_plus_one'
    { c: state[:c], d: state[:d]+1 }
  else
    state
  end
}
```

And you can combine reducers via `conbine`:

```ruby
Rubidux::Reducer.combine(r1: r1, r2: r2)
```

### Rubidux::Middleware
You can make a middleware via `init`:

```ruby
m1 = Rubidux::Middleware.init { |_next, action, **middleware_api|
  puts "#{action} in middleware 1"
  _next.(action)
}

m2 = Rubidux::Middleware.init { |_next, action, **middleware_api|
  puts "#{middleware_api[:get_state].()} in middleware 2"
  _next.(action)
}
```

And you can apply these middlewares via `apply`:

```ruby
enhancer = Rubidux::Middleware.apply m1, m2
```

### Rubidux::Store

You can initialize a new store instance:

```ruby
store = Rubidux::Store.new reducer, prestate, enhancer
```

And subscribe a listener via `subscribe`:

```ruby
unsubscribe_function = store.subscribe.(->{puts 'foo'})
unsubscribe_function.() # => This will unsubscribe listener
```

Most importantly, you can dispatch an action via `dispatch`:

```ruby
store.dispatch.({type: 'a_plus_one'})
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [here](https://github.com/davidjuin0519/rubidux).
