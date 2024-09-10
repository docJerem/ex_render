defmodule ExRender.Owner do
  @moduledoc "Serialization model for Render owners"
  @enforce_keys ~w(
    email
    id
    name
    two_factor_auth_enabled
    type
  )a

  defstruct @enforce_keys

  @type t :: %__MODULE__{
          email: String.t(),
          id: String.t(),
          two_factor_auth_enabled: boolean(),
          name: String.t(),
          type: String.t()
        }

  use ExConstructor
end
