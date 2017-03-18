defmodule Overpex.Parser.JSON do
  def parse(response) do
    %{"elements" => elements} = response |> Poison.decode! |> Enum.into(%{})
    elems = elements
            |> Enum.map(fn (node) -> node |> Enum.into(%{}) end)

    {:ok, %Overpex.Response{
      nodes:     parse_nodes(elems),
      ways:      parse_ways(elems),
      relations: parse_relations(elems)
    }}
  end

  defp parse_nodes(elems) do
    elems
    |> Enum.filter(fn %{"type" => type} -> type == "node" end)
    |> Enum.map(fn (node) ->
      %Overpex.Node{
        id:   node["id"],
        lat:  node["lat"],
        lon:  node["lon"],
        tags: node["tags"] |> parse_tags()
      }
    end)
  end

  defp parse_ways(elems) do
    elems
    |> Enum.filter(fn %{"type" => type} -> type == "way" end)
    |> Enum.map(fn (way) ->
      %Overpex.Way{
        id:    way["id"],
        nodes: way["nodes"],
        tags:  way["tags"] |> parse_tags()
      }
    end)
  end

  defp parse_relations(elems) do
    elems
    |> Enum.filter(fn %{"type" => type} -> type == "relation" end)
    |> Enum.map(fn (relation) ->
      %Overpex.Relation{
        id:      relation["id"],
        tags:    relation["tags"]    |> parse_tags(),
        members: relation["members"] |> parse_relation_members()
      }
    end)
  end

  defp parse_relation_members(collection) do
    collection |> Enum.map(&parse_relation_member/1)
  end

  defp parse_relation_member(%{"type" => type, "ref" => ref, "role" => role}) do
    %Overpex.RelationMember{
      type: type,
      ref:  ref,
      role: role
    }
  end

  defp parse_tags([]), do: []
  defp parse_tags(collection) do
    collection |> Enum.map(&parse_tag/1)
  end

  defp parse_tag({key, value}) do
    %Overpex.Tag{key: key, value: value}
  end
end
