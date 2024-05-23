defmodule ExRender.Deploys do
  @moduledoc """
  Render makes deploying your application as easy as pushing your code to source control.

  See how it works in [Render documentations](https://docs.render.com/deploys).
  """
  import ExRender.HttpHelpers, only: [req_options: 3]

  alias ExRender.{Commit, Deploy}

  @path "/services/:service_id/deploys"

  @spec list(String.t(), keyword(String.t())) :: list()
  @doc """
  Returns a list of Render `ExRender.Deploy` from a `ExRender.Service` owned by you or a team
  you belong to.


  ## Example

      iex> list("srv-some-service-id"))
      [
        %{
            cursor: "vsxehalH0Mtkb29sNmNhYzczYmsdqsdw",
            deploy: %ExRender.Deploy{
              commit: %ExRender.Commit{
                created_at: "2024-05-20T08:16:22Z",
                id: "some-commit-id",
                message: "Rest API challenge controller draft"
              },
              created_at: "2024-05-20T11:00:23.620137Z",
              finished_at: "2024-05-20T11:04:50.667727Z",
              id: "dep-some-deploy-id",
              status: "live",
              trigger: "service_resumed",
              updated_at: "2024-05-20T11:05:24.845489Z"
            }
          }
      ]

  """
  def list(service_id, params \\ [limit: 20]) do
    case Req.get!(options(service_id, "", params)) do
      %Req.Response{status: 200, body: services} ->
        Enum.map(services, fn %{"cursor" => c, "deploy" => s} ->
          %{cursor: c, deploy: deserialize(s)}
        end)

      _ ->
        []
    end
  end

  @spec trigger(String.t()) :: nil | ExRender.Deploy.t()
  @doc """
  Trigger a service by id

  ## Example

      iex> trigger("srv-some-service-id"))
      %ExRender.Deploy{
        commit: %ExRender.Commit{
          created_at: "2024-05-20T08:16:22Z",
          id: "some-commit-id",
          message: "Rest API challenge controller draft"
        },
        created_at: "2024-05-20T11:00:23.620137Z",
        finished_at: "2024-05-20T11:04:50.667727Z",
        id: "dep-some-deploy-id",
        status: "live",
        trigger: "service_resumed",
        updated_at: "2024-05-20T11:05:24.845489Z"
      }

  """
  def trigger(service_id) do
    case Req.post!(options(service_id, "")) do
      %Req.Response{status: 201, body: body} ->
        deserialize(body)

      _ ->
        nil
    end
  end

  @spec retrieve(String.t(), String.t()) :: nil | ExRender.Deploy.t()
  @doc """
  Returns the details of a single Render `ExRenderDeploy` (specified by serviceId) that's owned by
  you or a team you belong to.

  ## Example

      iex> retrieve("srv-some-service-id", "dp-some-deploy-id"))
      %ExRender.Deploy{
        commit: %ExRender.Commit{
          created_at: "2024-05-20T08:16:22Z",
          id: "some-commit-id",
          message: "Rest API challenge controller draft"
        },
        created_at: "2024-05-20T11:00:23.620137Z",
        finished_at: "2024-05-20T11:04:50.667727Z",
        id: "dep-some-deploy-id",
        status: "live",
        trigger: "service_resumed",
        updated_at: "2024-05-20T11:05:24.845489Z"
      }

  """
  def retrieve(service_id, deploy_id) do
    case Req.get!(options(service_id, "/#{deploy_id}")) do
      %Req.Response{status: 200, body: body} ->
        deserialize(body)

      _ ->
        nil
    end
  end

  @spec cancel(String.t(), String.t()) :: nil | ExRender.Deploy.t()
  @doc """
  This endpoint allows you to cancel a running deploy. Canceling cronjob deploys is
  currently not supported.

  ## Example

      iex> cancel("srv-some-service-id", "dp-some-deploy-id"))
      %ExRender.Deploy{
        commit: %ExRender.Commit{
          created_at: "2024-05-20T08:16:22Z",
          id: "some-commit-id",
          message: "Rest API challenge controller draft"
        },
        created_at: "2024-05-20T11:00:23.620137Z",
        finished_at: "2024-05-20T11:04:50.667727Z",
        id: "dep-some-deploy-id",
        status: "live",
        trigger: "service_resumed",
        updated_at: "2024-05-20T11:05:24.845489Z"
      }

  """
  def cancel(service_id, deploy_id) do
    case Req.post!(options(service_id, "/#{deploy_id}/cancel")) do
      %Req.Response{status: 200, body: body} ->
        deserialize(body)

      _ ->
        nil
    end
  end

  @spec rollback(String.t()) :: nil | ExRender.Deploy.t()
  @doc """
  Trigger a rollback to a previous deploy, by service id.

  ## Example

      iex> trigger("srv-some-service-id"))
      %ExRender.Deploy{
        commit: %ExRender.Commit{
          created_at: "2024-05-20T08:16:22Z",
          id: "some-commit-id",
          message: "Rest API challenge controller draft"
        },
        created_at: "2024-05-20T11:00:23.620137Z",
        finished_at: "2024-05-20T11:04:50.667727Z",
        id: "dep-some-deploy-id",
        status: "live",
        trigger: "service_resumed",
        updated_at: "2024-05-20T11:05:24.845489Z"
      }

  """
  def rollback(service_id) do
    case Req.post!(options(service_id, "")) do
      %Req.Response{status: 201, body: body} ->
        deserialize(body)

      _ ->
        nil
    end
  end

  defp deserialize(%{} = map) do
    map
    |> Deploy.new()
    |> Map.put(:commit, Commit.new(map["commit"]))
  end

  defp options(service_id, subpath, params \\ []) do
    @path
    |> String.replace(":service_id", service_id)
    |> req_options(subpath, params)
  end
end
