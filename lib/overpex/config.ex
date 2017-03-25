defmodule Overpex.Config do
  @moduledoc """
  Provides functions to get values defined on the config files
  """

  @doc """
  Get value from config files for `:key`
  
  ## Return values

  Returns the value found in the config files. If nothing is found, returns `nil`.
  """
  @spec get(atom) :: any | nil
  def get(key) when is_atom(key) do
    Application.get_env(:overpex, key)
  end

  @doc """
  Get default values from config files
  
  ## Return values

  Returns a map with `:url` and `:adapter` values fetched from the config files.
  """
  @spec default() :: %{url: any, adapter: any}
  def default do
    %{
      url:     get(:url),
      adapter: get(:adapter)
    }
  end
end
