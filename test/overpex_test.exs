defmodule OverpexTest do
  use ExUnit.Case
  doctest Overpex

  setup do
    {:ok, Overpex.Config.default} 
  end

  test "Overpex.API Error", options do
    options = %{options | url: options.url <> "error.json"}
    assert {:error, _} = Overpex.API.query("foo", options)
  end

  test "Overpex.API with QL and JSON-Response", options do
    options = %{options | url: options.url <> "success_json.json"}
    assert {:ok, {:json, _}} = Overpex.API.query(~s([out:json];node["name"="Gielgen"];out 2;), options)
  end

  test "Overpex.API with QL and XML-Response", options do
    options = %{options | url: options.url <> "success_xml.json"}
    assert {:ok, {:xml, _}} = Overpex.API.query(~s([out:xml];node[\"name\"=\"Gielgen\"];out 2;), options)
  end
end
