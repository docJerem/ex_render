defmodule ExRender.ServiceDetails do
  @moduledoc "Serialization model for Render service details of `ExRender.Service`"

  @enforce_keys ~w(
    autoscaling
    build_plan
    env
    env_specific_details
    num_instances
    plan
    pull_request_previews_enabled
    region
    open_ports
    url
    )a

  defstruct @enforce_keys

  @type t :: %__MODULE__{
          autoscaling: String.t(),
          build_plan: String.t(),
          env: String.t(),
          env_specific_details: term(),
          num_instances: integer(),
          open_ports: term(),
          plan: String.t(),
          pull_request_previews_enabled: term(),
          region: String.t(),
          url: String.t()
        }

  use ExConstructor
end
