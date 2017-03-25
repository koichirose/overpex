defmodule Overpex.API.Adapter.FakeTest do
  use ExUnit.Case

  setup do
    {:ok, Overpex.Config.default} 
  end

  test "post/2 raise error if file doesn't exist" do
    assert_raise File.Error, fn ->
      Overpex.API.Adapter.Fake.post("i_dont_exist", nil)
    end
  end

  test "post/2 raise error if JSON is invalid", options do
    url = options.url <> "invalid.json"
    assert_raise Poison.SyntaxError, fn ->
      Overpex.API.Adapter.Fake.post(url, nil)
    end
  end

  test "post/2 with success response", options do
    url = options.url <> "success_json.json"
    assert {:ok, %Overpex.API.Response{}} = Overpex.API.Adapter.Fake.post(url, nil)
  end

  test "post/2 with failure response", options do
    url = options.url <> "error.json"
    assert {:error, "Reason"} = Overpex.API.Adapter.Fake.post(url, nil)
  end
end
