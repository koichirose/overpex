use Mix.Config

config :overpex,
  url:     "http://overpass-api.de/api/interpreter",
  adapter: Overpex.API.Adapter.HTTPoison

import_config "#{Mix.env}.exs"
