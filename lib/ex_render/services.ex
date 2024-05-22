defmodule ExRender.Services do
  @moduledoc """
  When you retrieve a service's details with the Render API, many of the returned
  object's fields are the sameregardless of the service's type (static site, web
  service, etc.). However, certain fields are returned only for certain service types.

  See [Service Render API reference](https://api-docs.render.com/reference/service-fields) for
  more details.
  """
  import ExRender.HttpHelpers, only: [req_options: 3]

  @path "/services"

  alias ExRender.{Service, ServiceDetails}

  @spec list(keyword(integer())) :: list()
  @doc """
  Returns a list of Render services owned by you or a team you belong to. Optionally filter
  by name, service type, region, and more.
  """
  def list(params \\ [limit: 20]) do
    case Req.get!(options("", params)) do
      %Req.Response{status: 200, body: services} ->
        Enum.map(services, fn %{"cursor" => c, "service" => s} ->
          %{cursor: c, service: deserialize(s)}
        end)

      _ ->
        []
    end
  end

  @spec retrieve(String.t()) :: nil | Service.t()
  @doc """
  Returns the details of a single Render service (specified by serviceId) that's owned by
  you or a team you belong to.
  """
  def retrieve(service_id) do
    case Req.get!(options("/#{service_id}")) do
      %Req.Response{status: 200, body: body} ->
        deserialize(body)

      _ ->
        nil
    end
  end

  @spec suspend(String.t()) :: boolean()
  @doc "Suspend a service by id"
  def suspend(service_id) do
    result = Req.post!(options("/#{service_id}/suspend")).status

    result == 200 || result == 202
  end

  @spec resume(String.t()) :: boolean()
  @doc "Resume a service by id"
  def resume(service_id) do
    result = Req.post!(options("/#{service_id}/resume")).status

    result == 200 || result == 202
  end

  @spec restart(String.t()) :: boolean()
  @doc "Restart a service by id"
  def restart(service_id) do
    result = Req.post!(options("/#{service_id}/restart")).status

    result == 200 || result == 202
  end

  defp deserialize(%{} = map) do
    map
    |> Service.new()
    |> Map.put(:service_details, ServiceDetails.new(map["serviceDetails"]))
  end

  defp options(subpath, params \\ []), do: req_options(@path, subpath, params)
end
