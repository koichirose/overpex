defmodule Overpex.Overpass.Way do
  @moduledoc """
  List of nodes which normally has at least one tag.

  See http://wiki.openstreetmap.org/wiki/Way for more information
  """

  alias Overpex.Overpass.{Node, Tag}

  @type t :: %__MODULE__{
          id: integer,
          nodes: [%Node{}],
          tags: [%Tag{}]
        }

  defstruct id: 0, nodes: [], tags: []
end
