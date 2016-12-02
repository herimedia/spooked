# spooked

An experimental (and very limited!) unofficial Ruby client for the
[ghost.org / ghost.io blogging platform API](http://api.ghost.org/).

[![Gem Version](https://badge.fury.io/rb/spooked.svg)](https://badge.fury.io/rb/spooked)

## Usage

### Client Options

If not explicitly passed a client, all methods will fall back to
`Client.default_client`. You can set that default client directly or
have it auto-constructed from a set of default options:

#### access_token

**Has no default, must be provided.**

Your User Authentication Bearer Token. See
http://api.ghost.org/docs/user-authentication for details on how to obtain that
token.

#### connection_builder

**Optional**

A Faraday connection builder. Defaults to:

```ruby
->(builder) {
  builder.adapter   Faraday.default_adapter
  builder.request   :url_encoded
  builder.response  :parse_json
}
```

#### connection_options

**Optional**

A `Hash` of options passed as the second parameter to
`Faraday::Connection.new`.

#### subdomain

**Has no default, optional**

For ghost.io hosted ghost instances, set this to your ghost.io subdomain, i.e.
the word preceding `ghost.io` in the URL of your blog's administration
interface.

For self-hosted instances, you probably want to keep the `subdomain` empty and
overwrite `url_base` instead.

#### url_base

**Optional**

Defaults to `->(client) { "https://#{client.subdomain}.ghost.io/ghost/api/v0.1" }`.
You should generally only overwrite this if you self-host your ghost instance.

### APIs

- `Posts.list(fields: nil, filter: nil, include: nil, limit: 15, order: "published_at desc", page: 1)`

### Response format

All responses are returned as a `Hash` with all keys and values exactly
as described in the [API Reference Documentation](http://api.ghost.org/docs).

## Compatibility

So far, this has only been verified to work on Ruby (MRI) 2.3.3. I have
no plans to support any Ruby versions below 2.3.

## Status

This library is in a very early stage, only supports a very limited subset of
the API and further e.g. does not yet feature any automated tests, nor does it
significantly transform any API responses, provide convenience helpers, etc.

At the moment, The following APIs are supported:

- [GET /posts/](http://api.ghost.org/docs/posts)
