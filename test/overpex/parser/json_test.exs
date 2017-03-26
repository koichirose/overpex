defmodule Overpex.Parser.JSONTest do
  use ExUnit.Case
  alias Overpex.Parser.JSON
  alias Overpex.Overpass.{Node,Relation,RelationMember,Tag,Way}
  alias Overpex.Response

  test "parse/1 with empty string" do
    assert {:error, "Error parsing JSON\n\nResponse received: "} = JSON.parse("")
  end

  test "parse/1 with empty JSON" do
    assert {:error, "No elements to parse in response\n\nResponse received: {}"} = JSON.parse("{}")
  end

  test "parse/1 with invalid JSON" do
    assert {:error, "Error parsing JSON\n\nResponse received: {a: b}"} = JSON.parse("{a: b}")
  end

  test "parse/1 with non-binary response" do
    assert {:error, "Invalid response\n\nResponse received: 123"} = JSON.parse(123)
    assert {:error, "Invalid response\n\nResponse received: %{a: \"b\"}"} = JSON.parse(%{a: "b"})
  end

  test "parse/1 elements of type 'node'" do
    json_response = File.read!("test/support/fixtures/parse_nodes.json")
    assert {:ok, response = %Response{}} = JSON.parse(json_response)

    assert response.relations == []
    assert response.ways      == []
    assert response.nodes     == [
      %Node{id: 150947015, lat: 46.973427, lon: -123.69238, tags: [
          %Tag{key: "name",  value: "Central Park"},
          %Tag{key: "place", value: "village"}
        ]}]
  end

  test "parse/1 elements of type 'relation'" do
    json_response = File.read!("test/support/fixtures/parse_relations.json")
    assert {:ok, response = %Response{}} = JSON.parse(json_response)

    assert response.nodes     == []
    assert response.ways      == []
    assert response.relations == [
      %Relation{
        id: 1745069,
        members: [
          %RelationMember{type: "node", ref: 1627815522, role: "stop"},
          %RelationMember{type: "node", ref: 1564118492, role: "platform"},
          %RelationMember{type: "way",  ref: 4842146,    role: ""},
          %RelationMember{type: "way",  ref: 11159140,   role: ""}
        ],
        tags: [
          %Tag{key: "name", value: "VRS 636 Hangelar Ost"},
          %Tag{key: "type", value: "route"}
        ]
      }]
  end

  test "parse/1 elements of type 'way'" do
    json_response = File.read!("test/support/fixtures/parse_ways.json")
    assert {:ok, response = %Response{}} = JSON.parse(json_response)

    assert response.nodes     == []
    assert response.relations == []
    assert response.ways      == [
      %Way{
        id: 4842146,
        nodes: [26508622, 633736359],
        tags: [
          %Tag{key: "highway", value: "tertiary"},
          %Tag{key: "name",    value: "Konrad-Adenauer-Platz"}
        ]
      }]
  end

  test "parse/1 empty response" do
    json_response = File.read!("test/support/fixtures/parse_empty.json")
    assert {:ok, response = %Response{}} = JSON.parse(json_response)

    assert response.nodes     == []
    assert response.relations == []
    assert response.ways      == []
  end

  test "parse/1 complete response" do
    json_response = File.read!("test/support/fixtures/parse_complete.json")
    assert {:ok, response = %Response{}} = JSON.parse(json_response)

    assert response.nodes == [
      %Node{id: 150947015, lat: 46.973427, lon: -123.69238, tags: [
          %Tag{key: "name",  value: "Central Park"},
          %Tag{key: "place", value: "village"}
        ]}]

    assert response.relations == [
      %Relation{
        id: 1745069,
        members: [
          %RelationMember{type: "node", ref: 1627815522, role: "stop"},
          %RelationMember{type: "node", ref: 1564118492, role: "platform"},
          %RelationMember{type: "way",  ref: 4842146,    role: ""},
          %RelationMember{type: "way",  ref: 11159140,   role: ""}
        ],
        tags: [
          %Tag{key: "name", value: "VRS 636 Hangelar Ost"},
          %Tag{key: "type", value: "route"}
        ]
      }]

    assert response.ways == [
      %Way{
        id: 4842146,
        nodes: [26508622, 633736359],
        tags: [
          %Tag{key: "highway", value: "tertiary"},
          %Tag{key: "name",    value: "Konrad-Adenauer-Platz"}
        ]
      }]
  end
end
