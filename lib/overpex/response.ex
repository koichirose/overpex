defmodule Overpex.Response do
  @moduledoc """
  Response from Overpass API.

  Consists of a list of nodes, ways and relations.
  """

  alias Overpex.Overpass.{Node,Relation,Way}

  @type t :: %__MODULE__{
    nodes:     [%Node{}],
    ways:      [%Way{}],
    relations: [%Relation{}]
  }

  defstruct nodes: [], ways: [], relations: []
end
