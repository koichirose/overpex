use Mix.Config

config :overpex,
  url:     "http://overpass-api.de/api/interpreter",
  adapter: Overpex.HTTP.Adapter.HTTPoison

import_config "#{Mix.env}.exs"
