defmodule ExRender.Service do
  @doc "A Render service is the instance of your application"

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

  use ExConstructor
end
