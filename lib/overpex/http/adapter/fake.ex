defmodule Overpex.HTTP.Adapter.Fake do
  def post(url, _params) do
    url
    |> File.read!()
    |> Poison.decode!()
    |> build_response
  end

  defp build_response(response = %{"type" => "success"}) do
    {:ok,
      %Overpex.HTTP.Response{
        status_code: response["status"],
        body:        response["body"],
        headers:     response["headers"]
      }}
  end

  defp build_response(response = %{"type" => "failure"}) do
    {:error,
      %Overpex.HTTP.Error{
        reason: response["reason"],
        id:     response["id"]
      }}
  end

  defp build_response(error) do
    {:error, error}
  end
end
