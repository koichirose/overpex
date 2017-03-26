defmodule Overpex.Config do
  @moduledoc """
  Provides functions to get values defined on the config files
  """

  @doc """
  Get URL to the Overpass API
  
  ## Return values

  Returns the value found in the config files. If nothing is found, returns the default value
  """
  @spec url :: String.t
  def url do
    Application.get_env(:overpex, :url, "http://overpass-api.de/api/interpreter")
  end
end
