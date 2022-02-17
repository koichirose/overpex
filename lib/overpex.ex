defmodule Overpex do
  @moduledoc """
  Provides a function to query and parse response from Overpass API
  """

  @doc """
  Query Overpass API and parse response

  ## Return values

  If the query is successfull, the function returns `{:ok, response}`, where `response` is an `Overpex.Response` struct. If an error occurs, the function returns `{:error, error}`, where `error` is a String describing the error.
  """
  @spec query(String.t()) :: {:ok, %Overpex.Response{}} | {:error, String.t()}
  def query(query) do
    query
    |> Overpex.API.query()
    |> Overpex.Parser.parse()
  end
end
