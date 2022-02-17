defmodule Overpex.Parser do
  @moduledoc """
  Provides the functions to parse the response provided by the Overpass API.
  """

  @spec parse({:ok, {:xml, String.t()}}) :: {:ok, %Overpex.Response{}}
  def parse({:ok, {:xml, response}}) do
    Overpex.Parser.XML.parse(response)
  end

  @spec parse({:ok, {:json, String.t()}}) :: {:ok, %Overpex.Response{}}
  def parse({:ok, {:json, response}}) do
    Overpex.Parser.JSON.parse(response)
  end

  @spec parse({:error, String.t()}) :: {:error, String.t()}
  def parse({:error, error}), do: {:error, error}
end
