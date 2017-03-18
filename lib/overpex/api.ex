defmodule Overpex.API do
  def query(query, options \\ %{}) do
    Overpex.HTTP.post(query, options)
    |> process_response()
  end

  defp process_response({:ok, %Overpex.HTTP.Response{status_code: 200, body: body, headers: headers}}) do
    case headers["Content-Type"] do
      "application/osm3s+xml" -> {:ok,    {:xml,  body}}
      "application/json"      -> {:ok,    {:json, body}}
      _                       -> {:error, "Unsuported Content-Type"}
    end
  end

  defp process_response({:ok, %Overpex.HTTP.Response{status_code: code, body: _body, headers: _headers}}) do
    {:error, "status_code: #{code}"}
  end

  defp process_response({:error, error}) do
    {:error, error}
  end
end
