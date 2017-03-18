defmodule Overpex do
  def query(query, options \\ %{}) do
    query
    |> Overpex.API.query(options)
    |> Overpex.Parser.parse()
  end
end
