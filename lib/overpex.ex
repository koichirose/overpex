defmodule Overpex do
  @moduledoc """
  Provides a function to query and parse response from Overpass API
  """

  @doc """
  Query Overpass API and parse response

  ## Parameters

    - query: String that represents the query
    - options: Map with aditional options for the query. Supported options are `url` and `adapter`

  ## Examples

    iex> Overpex.query(~s([out:json];node["name"="Gielgen"];out 2;))
    {:ok, %Overpex.Response{}}

    iex> Overpex.query("foo")
    {:error, %Overpex.Error{}}
  """
  @spec query(String.t, map) :: {:ok, %Overpex.Response{}} | {:error, %Overpex.Error{}}
  def query(query, options \\ %{}) do
    query
    |> Overpex.API.query(options)
    |> Overpex.Parser.parse()
  end
end
