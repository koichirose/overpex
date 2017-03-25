defmodule Overpex.API.Adapter do
  @callback post(url :: String.t, query :: String.t) :: {:ok, %Overpex.API.Response{}} | {:error, String.t}
end
