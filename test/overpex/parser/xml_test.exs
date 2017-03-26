defmodule Overpex.Parser.XMLTest do
  use ExUnit.Case
  alias Overpex.Parser.XML
  alias Overpex.Overpass.{Node,Relation,RelationMember,Tag,Way}
  alias Overpex.Response

  test "parse/1 with empty string" do
    assert {:error, "Error parsing XML\n\nResponse received: "} = XML.parse("")
  end

  test "parse/1 with empty XML" do
    assert {:error, "No elements to parse in response\n\nResponse received: <nope></nope>"} = XML.parse("<nope></nope>")
  end

  test "parse/1 with invalid XML" do
    assert {:error, "Error parsing XML\n\nResponse received: <yep></nope>"} = XML.parse("<yep></nope>")
  end

  test "parse/1 with non-binary response" do
    assert {:error, "Invalid response\n\nResponse received: 123"} = XML.parse(123)
    assert {:error, "Invalid response\n\nResponse received: %{a: \"b\"}"} = XML.parse(%{a: "b"})
  end

  test "parse/1 elements of type 'node'" do
    xml_response = File.read!("test/support/fixtures/parse_nodes.xml") 
    assert {:ok, response = %Response{}} = XML.parse(xml_response)

    assert response.relations == []
    assert response.ways      == []
    assert response.nodes     == [
      %Node{id: 150947015, lat: 46.973427, lon: -123.69238, tags: [
          %Tag{key: "name",  value: "Central Park"},
          %Tag{key: "place", value: "village"}
        ]}]
  end

  test "parse/1 elements of type 'relation'" do
    xml_response = File.read!("test/support/fixtures/parse_relations.xml")
    assert {:ok, response = %Response{}} = XML.parse(xml_response)

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
    xml_response = File.read!("test/support/fixtures/parse_ways.xml")
    assert {:ok, response = %Response{}} = XML.parse(xml_response)

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
    xml_response = File.read!("test/support/fixtures/parse_empty.xml")
    assert {:ok, response = %Response{}} = XML.parse(xml_response)

    assert response.nodes     == []
    assert response.relations == []
    assert response.ways      == []
  end

  test "parse/1 complete response" do
    xml_response = File.read!("test/support/fixtures/parse_complete.xml")
    assert {:ok, response = %Response{}} = XML.parse(xml_response)

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
