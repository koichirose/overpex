defmodule Overpex.API.Response do
  defstruct status_code: nil, body: nil, headers: %{}
  @type t :: %__MODULE__{status_code: integer, body: term, headers: map}
end
