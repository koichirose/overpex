defmodule Overpex.ConfigTest do
  use ExUnit.Case

  test "url/0 with existing config" do
    Application.put_env(:overpex, :url, "http://example.com")
    assert Overpex.Config.url() == "http://example.com"
  end

  test "url/0 without config" do
    Application.delete_env(:overpex, :url)
    assert Overpex.Config.url() == "http://overpass-api.de/api/interpreter"
  end

  test "timeout/0 with existing config" do
    Application.put_env(:overpex, :timeout, 666)
    assert Overpex.Config.timeout() == 666
  end

  test "timeout/0 without config" do
    Application.delete_env(:overpex, :timeout)
    assert Overpex.Config.timeout() == 5000
  end
end
