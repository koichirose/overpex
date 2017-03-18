defmodule Overpex.Config do
  def get(key) when is_atom(key) do
    Application.get_env(:overpex, key)
  end

  def default do
    %{
      url:     get(:url),
      adapter: get(:adapter)
    }
  end
end
