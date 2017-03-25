defmodule Overpex.ConfigTest do
  use ExUnit.Case

  test "get/1 with existing config" do
    assert Overpex.Config.get(:adapter) == Overpex.API.Adapter.Fake
  end

  test "get/1 with non-existing config" do
    refute Overpex.Config.get(:foobar)
  end

  test "get/1 with invalid key" do
    assert_raise FunctionClauseError, fn ->
      Overpex.Config.get("not an atom")
    end
  end

  test "default/1" do
    assert Overpex.Config.default() == %{url: "test/support/fixtures/",
      adapter: Overpex.API.Adapter.Fake}
  end
end
