defmodule Overpex.Response do
  @moduledoc """
  Response from Overpass API.

  Consists of a list of nodes, ways and relations.
  """

  @type t :: %__MODULE__{
    nodes:     [%Overpex.Node{}],
    ways:      [%Overpex.Way{}],
    relations: [%Overpex.Relation{}]
  }

  defstruct nodes: [], ways: [], relations: []
end
