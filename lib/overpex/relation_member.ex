defmodule Overpex.RelationMember do
  @moduledoc """
  See http://wiki.openstreetmap.org/wiki/Relation for more information
  """

  @type t :: %__MODULE__{
    type: String.t,
    ref:  String.t,
    role: String.t,
  }

  defstruct type: "", ref: "", role: ""
end
