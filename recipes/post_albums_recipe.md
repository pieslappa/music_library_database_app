# POST /albums Route Design Recipe


## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

| What does it do   | Method | Path    | Query Params? | Body Parameters?                |
| ----------------- | ------ | ------- | ------------- | ------------------------------- |
| Adds a new album  | `POST` | /albums | N/A           | title= release_year= artist_id= |

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

```
Response when album added: 200 OK
```

## 3. Write Examples

_Replace these with your own design._

```
# POST:

POST /albums?title=Voyagerelease_year=2002artist_id=2

# Expected response:

Response for 200 OK
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "POST /albums" do
    it 'creates a new album' do
      params = 'title=Voyagerelease_year=2002artist_id=2'
      # Assuming the post with id 1 exists.
      response = get(
        '/albums',
        title: "Voyager",
        release_year: '2002',
        artist_id: '2'
      )

      expect(response.status).to eq(200)
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.