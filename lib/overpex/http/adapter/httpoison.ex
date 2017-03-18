defmodule Overpex.HTTP.Adapter.HTTPoison do
  def post(url, params) do
    HTTPoison.post(url, params)
    |> parse_response
  end

  defp parse_response({:ok, response = %HTTPoison.Response{}}) do
    {:ok,
      %Overpex.HTTP.Response{
        status_code: response.status_code,
        body:        response.body,
        headers:     Enum.into(response.headers, %{})
      }}
  end

  defp parse_response({:error, error = %HTTPoison.Error{}}) do
    {:error,
      %Overpex.HTTP.Error{
        reason: error.reason,
        id:     error.id
      }}
  end
end
