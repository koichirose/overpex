defmodule Overpex.API do
  @moduledoc """
  Provides a function to query the Overpass API
  """

  @doc """
  Query Overpass API

  ## Return values

  If the query is successfull, the function returns `{:ok, response}`, where `response` is a tuple `{:format, body}`. `:format` is either `:xml` or `:json`, and `body` is a String with the raw body. If an error occurs, the function returns `{:error, error}`, where `error` is a String describing the error.
  """
  @spec query(String.t()) ::
          {:ok, {:xml, String.t()}} | {:ok, {:json, String.t()}} | {:error, String.t()}
  def query(query) do
    Overpex.Config.url()
    |> HTTPoison.post(query, [{"timeout", Integer.to_string(Overpex.Config.timeout())}])
    |> process_response()
  end

  defp process_response(
         {:ok, %HTTPoison.Response{status_code: 200, body: body, headers: headers}}
       ) do
    headers
    |> Enum.into(%{})
    |> Map.get("Content-Type")
    |> case do
      "application/osm3s+xml" -> {:ok, {:xml, body}}
      "application/json" -> {:ok, {:json, body}}
      _ -> {:error, "Unsuported Content-Type"}
    end
  end

  defp process_response(
         {:ok, %HTTPoison.Response{status_code: code, body: _body, headers: _headers}}
       ) do
    {:error, "Invalid status code: #{code}. Expected 200"}
  end

  defp process_response({:ok, %HTTPoison.AsyncResponse{}}) do
    {:error, "Invalid response"}
  end

  defp process_response(_) do
    {:error, "unknown"}
  end
end
