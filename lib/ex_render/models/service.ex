defmodule ExRender.Service do
  @moduledoc "Serialization model for Render services"
  alias ExRender.Service.ServiceDetails

  @enforce_keys ~w(
    auto_deploy
    branch
    created_at
    id
    name
    notify_on_fail
    owner_id
    repo
    root_dir
    service_details
    slug
    suspended
    suspenders
    type
    updated_at
    )a

  defstruct @enforce_keys

  @type t :: %__MODULE__{
          auto_deploy: String.t(),
          branch: String.t(),
          created_at: String.t(),
          id: String.t(),
          name: String.t(),
          notify_on_fail: String.t(),
          owner_id: String.t(),
          repo: String.t(),
          root_dir: String.t(),
          service_details: ServiceDetails.t(),
          slug: String.t(),
          suspended: String.t(),
          suspenders: String.t(),
          type: String.t(),
          updated_at: String.t()
        }

  use ExConstructor
end
