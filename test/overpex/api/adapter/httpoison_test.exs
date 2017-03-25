defmodule Overpex.API.Adapter.HTTPoisonTest do
  use ExUnit.Case
  import Mock

  test "post/2 with success response" do
    url      = "http://example.com"
    query    = "query"
    response = %HTTPoison.Response{
      status_code: 200,
      body: "body",
      headers: [{"key", "value"}]
    }

    with_mock HTTPoison, [post: fn(_url, _query) -> {:ok, response} end] do
      assert {:ok, %Overpex.API.Response{
        status_code: 200,
        body: "body",
        headers: %{"key" => "value"}
      }} = Overpex.API.Adapter.HTTPoison.post(url, query)
      assert called HTTPoison.post(url, query)
    end
  end

  test "post/2 with failure response" do
    url      = "http://example.com"
    query    = "query"
    response = %HTTPoison.Error{reason: "You shall not pass!"}

    with_mock HTTPoison, [post: fn(_url, _query) -> {:error, response} end] do
      assert {:error, "You shall not pass!"} = Overpex.API.Adapter.HTTPoison.post(url, query)
      assert called HTTPoison.post(url, query)
    end
  end
end
