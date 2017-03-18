defmodule Overpex.Tag do
  @moduledoc """
  Key/Value strings that describe specific features of map elements (nodes, ways, or relations) or changesets.

  See http://wiki.openstreetmap.org/wiki/Tags for more information
  """

  @type t :: %__MODULE__{key: String.t, value: String.t}

  defstruct key: "", value: ""
end
