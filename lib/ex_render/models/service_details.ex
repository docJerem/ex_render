defmodule ExRender.ServiceDetails do
  @moduledoc false

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

  use ExConstructor
end
