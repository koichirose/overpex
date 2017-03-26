defmodule Overpex.APITest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start
    :ok
  end

  test "query/2 error" do
    use_cassette "error" do
      assert {:error, "Invalid status code: 400. Expected 200"} = Overpex.API.query("foo")
    end
  end

  test "query/2 error content type" do
    use_cassette "error_content_type" do
      assert {:error, "Unsuported Content-Type"} = Overpex.API.query(~s([out:json];node["name"="Central Park"];out 1;))
    end
  end

  test "query/2 success with JSON response" do
    use_cassette "success_json" do
      assert {:ok, {:json, _}} = Overpex.API.query(~s([out:json];node["name"="Central Park"];out 1;))
    end
  end

  test "query/2 success with XML response" do
    use_cassette "success_xml" do
      assert {:ok, {:xml, _}} = Overpex.API.query(~s([out:xml];node["name"="Central Park"];out 1;))
    end
  end
end
