defmodule Overpex.API.Adapter.Fake do
  @behaviour Overpex.API.Adapter

  def post(url, _query) do
    url
    |> File.read!()
    |> Poison.decode!()
    |> build_response
  end

  defp build_response(response = %{"type" => "success"}) do
    {:ok,
      %Overpex.API.Response{
        status_code: response["status"],
        body:        response["body"],
        headers:     response["headers"]
      }}
  end

  defp build_response(response = %{"type" => "failure"}) do
    {:error, response["reason"]}
  end
end
