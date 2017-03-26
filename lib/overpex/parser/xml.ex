defmodule Overpex.Parser.XML do
  @moduledoc """
  Provides functions to parse XML response from Overpass API
  """

  import SweetXml
  alias Overpex.Overpass.{Node,Relation,RelationMember,Tag,Way}
  alias Overpex.Response

  @doc """
  Parses XML response from Overpass API

  ## Return values

  Returns `{:ok, response}`, where `response` is an `Overpex.Response` struct. Returns `{:error, error}` if the XML is empty or invalid, where `error` is a String describing the error.
  """
  @spec parse(String.t) :: {:ok, %Response{}} | {:error, String.t}
  def parse(response)

  def parse(response) when is_binary(response) do
    try do
      case xpath(response, ~x"//osm") do
        nil   -> error_response("No elements to parse in response", response)
        elems ->
          {:ok, %Response{
            nodes:     parse_nodes(elems),
            ways:      parse_ways(elems),
            relations: parse_relations(elems)
          }}
      end
    catch
      # Handle SweetXML through :exit if the XML is invalid
      :exit, _ -> error_response("Error parsing XML", response)
    end
  end

  def parse(response) do
    error_response("Invalid response", inspect(response))
  end

  defp error_response(message, response) do
    {:error, "#{message}\n\nResponse received: #{response}"}
  end

  defp parse_nodes(osm) do
    osm
    |> xpath(~x"./node"l)
    |> Enum.map(fn (node) ->
      %Node{
        id:   node |> xpath(~x"./@id"i),
        lat:  node |> xpath(~x"./@lat"s) |> String.to_float(),
        lon:  node |> xpath(~x"./@lon"s) |> String.to_float(),
        tags: node |> parse_tags()
      }
    end)
  end

  defp parse_ways(osm) do
    osm
    |> xpath(~x"./way"l)
    |> Enum.map(fn (way) ->
      %Way{
        id:    way |> xpath(~x"./@id"i),
        nodes: way |> xpath(~x"./nd"l)  |> Enum.map(fn (nd) -> nd |> xpath(~x"./@ref"i) end),
        tags:  way |> parse_tags()
      }
    end)
  end

  defp parse_relations(osm) do
    osm
    |> xpath(~x"./relation"l)
    |> Enum.map(fn (relation) ->
      %Relation{
        id:      relation |> xpath(~x"./@id"i),
        members: relation |> parse_relation_members() ,
        tags:    relation |> parse_tags()
      }
    end)
  end

  defp parse_relation_members(collection) do
    collection
    |> xpath(~x"./member"l)
    |> Enum.map(&parse_relation_member/1)
  end

  defp parse_relation_member(member) do
    %RelationMember{
      type: member |> xpath(~x"./@type"s),
      ref:  member |> xpath(~x"./@ref"i),
      role: member |> xpath(~x"./@role"s)
    }
  end

  defp parse_tags(collection) do
    collection
    |> xpath(~x"./tag"l)
    |> Enum.map(&parse_tag/1)
    |> Enum.sort(fn(a, b) -> a.key <= b.key end)
  end

  defp parse_tag(tag) do
    %Tag{
      key:   xpath(tag, ~x"./@k"s),
      value: xpath(tag, ~x"./@v"s)
    }
  end
end
