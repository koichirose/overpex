defmodule Overpex do
  @moduledoc """
  Provides a function to query and parse response from Overpass API
  """

  @doc """
  Query Overpass API and parse response

  ## Options

  The `:url` option is used to define the URL to access the Overpass API. The default URL is `http://overpass-api.de/api/interpreter`

  The `:adapter` option defines the API adapter used to access the Overpass API. Currently the only adapters available are `Overpex.API.Adapter.HTTPoison` and `Overpex.API.Adapter.Fake`. Defaults to `Overpex.API.Adapter.HTTPoison` on all envs except `test`. On `test` it defaults to `Overpex.API.Adapter.Fake`

  The default values can be overriden using `options` or by setting the appropiate values on your `config` file:

  ```elixir
  config :overpex,
    url:     "http://overpass-api.de/api/interpreter",
    adapter: Overpex.API.Adapter.HTTPoison
  ```

  ## Return values

  If the query is successfull, the function returns `{:ok, response}`, where `response` is an `Overpex.Response` struct. If an error occurs, the function returns `{:error, error}`, where `error` is a String describing the error.
  """
  @spec query(String.t, map) :: {:ok, %Overpex.Response{}} | {:error, String.t}
  def query(query, options \\ %{}) do
    query
    |> Overpex.API.query(options)
    |> Overpex.Parser.parse()
  end
end
