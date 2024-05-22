defmodule ExRender.HttpHelpers do
  @moduledoc "Collection of helpers for HTTP requests"

  @spec req_options(binary(), binary(), keyword()) :: keyword()
  @doc "HTTP options of req middleware"
  def req_options(path, subpath, params) do
    Keyword.merge(
      [
        base_url: ExRender.root(),
        url: path <> subpath,
        params: params,
        auth: bearer()
      ],
      Application.get_env(:ex_render, :ex_render_req_options, [])
    )
  end

  defp bearer, do: {:bearer, ExRender.api_key()}
end
