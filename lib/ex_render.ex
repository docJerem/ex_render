defmodule ExRender do
  @moduledoc """
  Documentation for `ExRender`.
  """

  @root "https://api.render.com/v1"

  @doc "Return the API key from config.exs"
  def api_key do
    Application.get_env(:ex_render, :api_key) ||
      raise """
      Missing API key

      Please add Render.com API key :

      # config/prod.secret.exs or dev.secret.exs
      config :ex_render, :api_key, "my_api_key"
      """
  end

  def bearer, do: {:bearer, api_key()}

  @doc "Return the root of the API"
  def root, do: @root

  def deserializer(map) do
    for {key, val} <- map, into: %{} do
      {String.to_existing_atom(Macro.underscore(key)), val}
    end
  end
end
