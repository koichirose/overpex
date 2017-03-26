defmodule Overpex.Overpass.Relation do
  @moduledoc """
  See http://wiki.openstreetmap.org/wiki/Relation for more information.
  """
  
  alias Overpex.Overpass.{RelationMember,Tag}

  @type t :: %__MODULE__{
    id:      integer,
    members: [%RelationMember{}],
    tags:    [%Tag{}]
  }

  defstruct id: 0, members: [], tags: []
end
