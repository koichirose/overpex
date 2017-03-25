# Overpex

[![Build Status](https://travis-ci.org/brunoasantos/overpex.svg?branch=master)](https://travis-ci.org/brunoasantos/overpex)
[![Hex.pm](https://img.shields.io/hexpm/v/overpex.svg)](https://hex.pm/packages/overpex)

Simple wrapper for [Overpass API](https://wiki.openstreetmap.org/wiki/Overpass_API).

## Installation

Add `overpex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:overpex, "~> 0.2.0"}]
end
```

Documentation can be found at [https://hexdocs.pm/overpex](https://hexdocs.pm/overpex).

## Config

Set the URL for [Overpass API](https://wiki.openstreetmap.org/wiki/Overpass_API) in `config/config.exs`:

```elixir
config :overpex,
  url: "http://overpass-api.de/api/interpreter"
```

The default URL is `http://overpass-api.de/api/interpreter`.

You can also set a custom adapter to access the API. The default is `Overpex.API.Adapter.HTTPoison`. Please check the [documentation](https://hexdocs.pm/overpex) for more information on adapters.

## Usage

Query for nodes with name `Gielgen` without the body:

```elixir
iex> Overpex.query(~s(node["name"="Gielgen"];out skel;))
{:ok,
 %Overpex.Response{nodes: [%Overpex.Node{id: 371597317, lat: 50.7412721,
    lon: 7.192712, tags: []},
   %Overpex.Node{id: 373373733, lat: 50.7290803, lon: 7.2176116, tags: []},
   %Overpex.Node{id: 507464799, lat: 50.739397, lon: 7.1959361, tags: []},
   (...)],
  relations: [], ways: []}}
```

Query for nodes with name `Gielgen` with the body:

```elixir
iex> Overpex.query(~s(node["name"="Gielgen"];out body;))
{:ok,
 %Overpex.Response{nodes: [%Overpex.Node{id: 371597317, lat: 50.7412721,
    lon: 7.192712,
    tags: [%Overpex.Tag{key: "is_in",
      value: "Bonn,Regierungsbezirk Köln,Nordrhein-Westfalen,Bundesrepublik Deutschland,Europe"},
     %Overpex.Tag{key: "name", value: "Gielgen"},
     %Overpex.Tag{key: "place", value: "suburb"}]},
   %Overpex.Node{id: 373373733, lat: 50.7290803, lon: 7.2176116,
    tags: [%Overpex.Tag{key: "name", value: "Gielgen"},
     %Overpex.Tag{key: "shop", value: "bakery"},
     %Overpex.Tag{key: "wheelchair", value: "yes"}]},
   (...)],
  relations: [], ways: []}}
```

`Overpex.Query/1` will automatically parse the response for you. In case you want to get the HTTP response and do the parse yourself, use `Overpex.API.query/1`:

```elixir
iex> Overpex.API.query(~s(node["name"="Gielgen"];out skel;))
{:ok, {:xml, "(...)"}}
  
iex> Overpex.API.query(~s([out:json];node["name"="Gielgen"];out skel;))
{:ok, {:json, "(...)"}}
```

## Credits

Inspired by [https://github.com/CodeforChemnitz/elixir-overpass](https://github.com/CodeforChemnitz/elixir-overpass)

## License

[The MIT License (MIT)](https://github.com/brunoasantos/overpex/blob/master/LICENSE)
