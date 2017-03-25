defmodule Overpex.API.Adapter.HTTPoison do
  @behaviour Overpex.API.Adapter

  def post(url, query) do
    HTTPoison.post(url, query)
    |> parse_response
  end

  defp parse_response({:ok, response = %HTTPoison.Response{}}) do
    {:ok,
      %Overpex.API.Response{
        status_code: response.status_code,
        body:        response.body,
        headers:     Enum.into(response.headers, %{})
      }}
  end

  defp parse_response({:error, error = %HTTPoison.Error{}}) do
    {:error, error.reason}
  end
end
