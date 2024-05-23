defmodule ExRender.Deploy do
  @moduledoc "Serialization model for Render service details of `ExRender.Service`"
  alias ExRender.Commit

  @enforce_keys ~w(
    commit
    created_at
    finished_at
    id
    status
    trigger
    updated_at
    )a

  defstruct @enforce_keys

  @type t :: %__MODULE__{
          commit: Commit.t(),
          created_at: String.t(),
          finished_at: String.t(),
          id: String.t(),
          status: String.t(),
          trigger: String.t(),
          updated_at: String.t()
        }

  use ExConstructor
end
