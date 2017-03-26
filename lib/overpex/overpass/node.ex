defmodule Overpex.Overpass.Node do
  @moduledoc """
  A node is one of the core elements in the OpenStreetMap data model. It consists of a single point in space defined by its latitude, longitude and node id.

  See http://wiki.openstreetmap.org/wiki/Node for more information
  """

  @type t :: %__MODULE__{
    id:   integer,
    lat:  float,
    lon:  float,
    tags: []
  }

  defstruct id: 0, lat: 0.0, lon: 0.0, tags: []
end
