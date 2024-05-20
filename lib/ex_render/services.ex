defmodule ExRender.Services do
  @moduledoc """
  When you retrieve a service's details with the Render API, many of the returned
  object's fields are the sameregardless of the service's type (static site, web
  service, etc.). However, certain fields are returned only for certain service types.

  See [Service Render API reference](https://api-docs.render.com/reference/service-fields) for
  more details.
  """
  import ExRender, only: [bearer: 0, root: 0]

  @path "/services"

  @doc """
  Returns a list of Render services owned by you or a team you belong to. Optionally filter
  by name, service type, region, and more.
  """
  def list(params \\ [limit: 20]),
    do: Req.get!(url(), params: params, auth: bearer()).body()

  @doc """
  Returns the details of a single Render service (specified by serviceId) that's owned by
  you or a team you belong to.
  """
  def retrieve(service_id),
    do: Req.get!(url() <> "/#{service_id}", auth: bearer()).body()

  @doc "Suspend a service by id"
  def suspend(service_id) do
    result = Req.post!(url() <> "/#{service_id}/suspend", auth: bearer()).status

    result == 202 || result == 200
  end

  @doc "Resume a service by id"
  def resume(service_id) do
    result = Req.post!(url() <> "/#{service_id}/resume", auth: bearer()).status

    result == 202 || result == 200
  end

  @doc "Restart a service by id"
  def restart(service_id) do
    result = Req.post!(url() <> "/#{service_id}/restart", auth: bearer()).status

    result == 202 || result == 200
  end

  defp url, do: root() <> @path
end
