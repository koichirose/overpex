defmodule Overpex.Relation do
  @moduledoc """
  See http://wiki.openstreetmap.org/wiki/Relation for more information.
  """

  @type t :: %__MODULE__{
    id:      integer,
    members: [%Overpex.RelationMember{}],
    tags:    [%Overpex.Tag{}]
  }

  defstruct id: 0, members: [], tags: []
end
