defmodule Overpex.Way do
  @moduledoc """
  List of nodes which normally has at least one tag.

  See http://wiki.openstreetmap.org/wiki/Way for more information
  """

  @type t :: %__MODULE__{
    id:    integer,
    nodes: [%Overpex.Node{}],
    tags:  [%Overpex.Tag{}]
  }

  defstruct id: 0, nodes: [], tags: []
end
