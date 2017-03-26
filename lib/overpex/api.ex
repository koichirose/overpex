defmodule Overpex.API do
  @moduledoc """
  Provides a function to query the Overpass API
  """

  @doc """
  Query Overpass API

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

  If the query is successfull, the function returns `{:ok, response}`, where `response` is a tuple `{:format, body}`. `:format` is either `:xml` or `:json`, and `body` is a String with the raw body. If an error occurs, the function returns `{:error, error}`, where `error` is a String describing the error.
  """
  @spec query(String.t, map) :: {:ok, {:xml, String.t}} | {:ok, {:json, String.t}} | {:error, String.t}
  def query(query, options \\ %{}) do
    options = Map.merge(Overpex.Config.default, options)

    apply(options[:adapter], :post, [options[:url], query])
    |> process_response()
  end

  defp process_response({:ok, %Overpex.API.Response{status_code: 200, body: body, headers: headers}}) do
    case headers["Content-Type"] do
      "application/osm3s+xml" -> {:ok,    {:xml,  body}}
      "application/json"      -> {:ok,    {:json, body}}
      _                       -> {:error, "Unsuported Content-Type"}
    end
  end

  defp process_response({:ok, %Overpex.API.Response{status_code: code, body: _body, headers: _headers}}) do
    {:error, "Invalid status code: #{code}. Expected 200"}
  end

  defp process_response({:error, error}) do
    {:error, error}
  end
end
