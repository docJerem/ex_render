defmodule ExRender.PostgreSQL do
  @moduledoc "Serialization model for Render postgresql"
  alias ExRender.Owner

  @enforce_keys ~w(
    created_at
    dashboard_url
    dashboard_name
    dashboard_user
    high_availability_enabled
    id
    ip_allowed_list
    name
    owner
    plan
    read_replicas
    region
    role
    status
    suspended
    suspenders
    type
    updated_at
    version
    )a

  defstruct @enforce_keys

  @type t :: %__MODULE__{
          created_at: String.t(),
          dashboard_url: String.t(),
          dashboard_name: String.t(),
          dashboard_user: String.t(),
          high_availability_enabled: Boolean.t(),
          id: String.t(),
          ip_allowed_list: list(),
          name: String.t(),
          owner: Owner.t(),
          plan: String.t(),
          read_replicas: list(),
          region: String.t(),
          role: String.t(),
          status: String.t(),
          suspended: String.t(),
          suspenders: String.t(),
          type: String.t(),
          updated_at: String.t(),
          version: Integer.t()
        }

  use ExConstructor
end
