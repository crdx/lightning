# Lightning Web Framework

**lightning** is a web framework written in Ruby.

## Dependencies

| Component  | Provided by       |
|------------|-------------------|
| Base       | Sinatra + Rack    |
| Routes     | Sinatra           |
| Views      | Sinatra (erubis)  |
| Models     | ActiveRecord      |
| Migrations | ActiveRecord      |
| Tests      | Rack::Test        |
| Security   | Rack::Protection  |

## Usage

Create a file named `web.rb` in the root of the project.

```rb
require 'lightning-framework'

class Web < Lightning::Base
    set_app_file __FILE__

    enable_compression
    enable_session
    enable_db

    get '/' do
        @people = Person.all
        erb :index
    end
end
```

This is an instance of `Sinatra::Base`.

### Models

Create the file `models/person.rb`.

```rb
class Person < Lightning::Record
end
```

This is an instance of `ActiveRecord::Base`.

### Views

Create the file `views/index.erb`.

```erb
<% @people.each do |person| %>
    <div><%= person.name %> is <%= person.age %> years old</div>
<% end %>
```

Any format supported by Sinatra is supported here.

A view called `layout.erb` will be automatically used as a layout. Call `<%== yield %>` inside the layout.

### Middleware

Use Sinatra-based middleware by implementing `Lightning::Middleware`.

This is also an instance of `Sinatra::Base` but isolated from the others.

For example, given the following simple implementation of authentication middleware.

```rb
module Middleware
    class Auth < Lightning::Middleware
        before do
            halt 400 if params[:password] != 'secret'
        end
    end
end
```

This can be used with the `use` statement in the main implementation of `Lightning::Base`.

```rb
class Web < Lightning::Base
    # ...
    use Middleware::Auth
    # ...
end
```

### Database

Run the following command to see the list of tasks.

```bash
bundle exec rake --tasks
```

#### `g:migration <name>`

Generate a new migration. Use lower snakecase e.g. `create_some_table`.

#### `db:migrate`

Migrate the database to the latest version available.

#### `db:drop`, `db:create`

Drop the database, or create the database.

#### `db:reset`

Drop, create, and migrate.

### Integration tests

Include `lightning-framework/spec_helper` in `spec_helper` to bring the helpers into scope.

### Environment

`ENV['RACK_ENV']` is used to determine the current environment. If it is not valid, the framework will error immediately.

Environment variables must be stored in a file in the `env/` folder, where the filename is one of the following.

- `development`
- `production`
- `test`

For example, `env/development`.

## Security

### CSRF

SameSite cookies are enabled by default, which _somewhat_ mitigates CSRF. For proper protection a standard CSRF token implementation is still recommended.

### CSP

A content security policy can be enabled and configured using `enable_csp`.

### Output escaping

By default with `erb` templates all output is automatically escaped.

## Contributions

Open an [issue](https://github.com/crdx/lightning/issues) or send a [pull request](https://github.com/crdx/lightning/pulls).

## Licence

[GPLv3](LICENCE).
