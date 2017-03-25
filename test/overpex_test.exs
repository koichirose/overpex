defmodule OverpexTest do
  use ExUnit.Case

  setup do
    {:ok, Overpex.Config.default} 
  end

  test "query/2 error", options do
    options = %{options | url: options.url <> "error.json"}
    assert {:error, "Reason"} = Overpex.query("foo", options)
  end

  test "query/2 error content type", options do
    options = %{options | url: options.url <> "error_content_type.json"}
    assert {:error, "Unsuported Content-Type"} = Overpex.query("foo", options)
  end

  test "query/2 error status code", options do
    options = %{options | url: options.url <> "error_status_code.json"}
    assert {:error, "Invalid status code: 201. Expected 200"} = Overpex.query("foo", options)
  end

  test "query/2 success with JSON response", options do
    options = %{options | url: options.url <> "success_json.json"}
    assert {:ok, %Overpex.Response{}} = Overpex.query(~s([out:json];node["name"="Central Park"];out 1;), options)
  end

  test "query/2 success with XML response", options do
    options = %{options | url: options.url <> "success_xml.json"}
    assert {:ok, %Overpex.Response{}} = Overpex.query(~s([out:xml];node["name"="Central Park"];out 1;), options)
  end
end
