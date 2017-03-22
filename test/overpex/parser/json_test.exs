defmodule Overpex.Parser.JSONTest do
  use ExUnit.Case
  alias Overpex.Parser.JSON

  test "parse/1 with empty string" do
    assert {:error, %Overpex.Error{reason: "Error parsing JSON\n\nResponse received: "}} = JSON.parse("")
  end

  test "parse/1 with empty JSON" do
    assert {:error, %Overpex.Error{reason: "No elements to parse in response\n\nResponse received: {}"}} = JSON.parse("{}")
  end

  test "parse/1 with invalid JSON" do
    assert {:error, %Overpex.Error{reason: "Error parsing JSON\n\nResponse received: {a: b}"}} = JSON.parse("{a: b}")
  end

  test "parse/1 with non-binary response" do
    assert {:error, %Overpex.Error{reason: "Invalid response\n\nResponse received: 123"}} = JSON.parse(123)
    assert {:error, %Overpex.Error{reason: "Invalid response\n\nResponse received: %{a: \"b\"}"}} = JSON.parse(%{a: "b"})
  end

  test "parse/1 elements of type 'node'" do
    json_response = File.read!("test/support/fixtures/parse_json_nodes.json") 
    assert {:ok, response = %Overpex.Response{}} = JSON.parse(json_response)
    assert response.nodes == [
      %Overpex.Node{id: 150947015, lat: 46.973427, lon: -123.69238, tags: [
          %Overpex.Tag{key: "name", value: "Central Park"},
          %Overpex.Tag{key: "place", value: "village"}
        ]}]
    assert response.relations == []
    assert response.ways      == []
  end
end
