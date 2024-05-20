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

  alias ExRender.{Service, ServiceDetails}

  @doc """
  Returns a list of Render services owned by you or a team you belong to. Optionally filter
  by name, service type, region, and more.
  """
  def list(params \\ [limit: 20]) do
    case Req.get!(url(), options(params)) do
      %Req.Response{status: 200, body: services} ->
        Enum.map(services, fn %{"cursor" => c, "service" => s} ->
          %{cursor: c, service: deserialize(s)}
        end)

      _ ->
        []
    end
  end

  @doc """
  Returns the details of a single Render service (specified by serviceId) that's owned by
  you or a team you belong to.
  """
  def retrieve(service_id) do
    case Req.get!(url() <> "/#{service_id}", options()) do
      %Req.Response{status: 200, body: body} ->
        deserialize(body)

      _ ->
        nil
    end
  end

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

  defp deserialize(%{} = map) do
    map
    |> Service.new()
    |> Map.put(:service_details, ServiceDetails.new(map["serviceDetails"]))
  end

  defp options(params \\ []) do
    Keyword.merge(
      [
        base_url: root(),
        url: @path,
        params: params,
        auth: bearer()
      ],
      Application.get_env(:ex_render, :ex_render_req_options, [])
    )
  end

  defp url, do: root() <> @path
end
