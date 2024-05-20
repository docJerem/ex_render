defmodule ExRender.ServiceDetails do
  @doc "Details of a Render Service"

  @enforce_keys ~w(
    autoscaling
    build_plan
    env
    env_specific_details
    num_instances
    plan
    pull_request_previews_enabled
    region
    url
    )a

  defstruct @enforce_keys

  use ExConstructor
end
