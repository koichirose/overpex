defmodule Overpex.Parser.JSON do
  @moduledoc """
  Provides functions to parse JSON response from Overpass API
  """

  alias Overpex.Overpass.{Node, Relation, RelationMember, Tag, Way}
  alias Overpex.Response

  @doc """
  Parses JSON response from Overpass API

  ## Return values

  Returns `{:ok, response}`, where `response` is an `Overpex.Response` struct. Returns `{:error, error}` if the JSON is empty or invalid, where `error` is a String describing the error.
  """
  @spec parse(String.t()) :: {:ok, %Response{}} | {:error, String.t()}
  def parse(response)

  def parse(response) when is_binary(response) do
    with {:ok, json} <- Poison.decode(response),
         %{"elements" => elements} <- Enum.into(json, %{}),
         elems <- Enum.map(elements, fn node -> Enum.into(node, %{}) end) do
      {:ok,
       %Response{
         nodes: parse_nodes(elems),
         ways: parse_ways(elems),
         relations: parse_relations(elems)
       }}
    else
      {:error, :invalid, _} -> error_response("Error parsing JSON", response)
      {:error, {:invalid, _, _}} -> error_response("Error parsing JSON", response)
      %{} -> error_response("No elements to parse in response", response)
      error -> error_response("Error parsing JSON: #{inspect(error)}", inspect(response))
    end
  end

  def parse(response) do
    error_response("Invalid response", inspect(response))
  end

  defp error_response(message, response) do
    {:error, "#{message}\n\nResponse received: #{response}"}
  end

  defp parse_nodes(elems) do
    elems
    |> Enum.filter(fn %{"type" => type} -> type == "node" end)
    |> Enum.map(fn node ->
      %Node{
        id: node["id"],
        lat: node["lat"],
        lon: node["lon"],
        tags: node["tags"] |> parse_tags()
      }
    end)
  end

  defp parse_ways(elems) do
    elems
    |> Enum.filter(fn %{"type" => type} -> type == "way" end)
    |> Enum.map(fn way ->
      %Way{
        id: way["id"],
        nodes: way["nodes"],
        tags: way["tags"] |> parse_tags()
      }
    end)
  end

  defp parse_relations(elems) do
    elems
    |> Enum.filter(fn %{"type" => type} -> type == "relation" end)
    |> Enum.map(fn relation ->
      %Relation{
        id: relation["id"],
        tags: relation["tags"] |> parse_tags(),
        members: relation["members"] |> parse_relation_members()
      }
    end)
  end

  defp parse_relation_members(collection) do
    collection |> Enum.map(&parse_relation_member/1)
  end

  defp parse_relation_member(%{"type" => type, "ref" => ref, "role" => role}) do
    %RelationMember{
      type: type,
      ref: ref,
      role: role
    }
  end

  defp parse_tags([]), do: []

  defp parse_tags(collection) do
    collection
    |> Enum.map(&parse_tag/1)
    |> Enum.sort(fn a, b -> a.key <= b.key end)
  end

  defp parse_tag({key, value}) do
    %Tag{key: key, value: value}
  end
end
