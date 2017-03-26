defmodule Overpex.ConfigTest do
  use ExUnit.Case

  test "url/1 with existing config" do
    Application.put_env(:overpex, :url, "http://example.com")
    assert Overpex.Config.url() == "http://example.com"
  end

  test "url/1 without config" do
    Application.delete_env(:overpex, :url)
    assert Overpex.Config.url() == "http://overpass-api.de/api/interpreter"
  end
end
