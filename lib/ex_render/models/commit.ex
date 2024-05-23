defmodule ExRender.Commit do
  @moduledoc "Serialization model for Render commit"

  @enforce_keys ~w(
    created_at
    id
    message
    )a

  defstruct @enforce_keys

  @type t :: %__MODULE__{
          created_at: String.t(),
          id: String.t(),
          message: String.t()
        }

  use ExConstructor
end
