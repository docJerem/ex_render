defmodule ExRender.Postgres do
  @moduledoc """
  When you retrieve a postgres's details with the Render API, many of the returned
  object's fields are the sameregardless of the postgres's type.
  """
  import ExRender.HttpHelpers, only: [req_options: 3]

  alias ExRender.{Owner, PostgreSQL}

  @path "/postgres"

  @spec list(keyword(integer())) :: list()
  @doc """
  Returns a list of Render PostgreSQL owned by you or a team you belong to. Optionally filter
  by name, service type, region, and more.
  """
  def list(params \\ [limit: 20]) do
    case Req.get!(options("", params)) do
      %Req.Response{status: 200, body: postgres} ->
        Enum.map(postgres, fn %{"cursor" => c, "postgres" => pg} ->
          %{cursor: c, postgres: deserialize(pg)}
        end)

      _ ->
        []
    end
  end

  @spec retrieve(String.t()) :: nil | Service.t()
  @doc """
  Returns the details of a single Render postgres (specified by postgresId) that's owned by
  you or a team you belong to.
  """
  def retrieve(postgres_id) do
    case Req.get!(options("/#{postgres_id}")) do
      %Req.Response{status: 200, body: body} ->
        deserialize(body)

      _ ->
        nil
    end
  end

  @spec suspend(String.t()) :: boolean()
  @doc "Suspend a postgres by id"
  def suspend(postgres_id) do
    result = Req.post!(options("/#{postgres_id}/suspend")).status

    result == 200 || result == 202
  end

  @spec resume(String.t()) :: boolean()
  @doc "Resume a postgres by id"
  def resume(postgres_id) do
    result = Req.post!(options("/#{postgres_id}/resume")).status

    result == 200 || result == 202
  end

  @spec restart(String.t()) :: boolean()
  @doc "Restart a postgres by id"
  def restart(postgres_id) do
    result = Req.post!(options("/#{postgres_id}/restart")).status

    result == 200 || result == 202
  end

  defp deserialize(%{} = map) do
    map
    |> PostgreSQL.new()
    |> Map.put(:owner, Owner.new(map["owner"]))
  end

  defp options(subpath, params \\ []), do: req_options(@path, subpath, params)
end
