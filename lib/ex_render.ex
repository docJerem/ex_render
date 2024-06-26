defmodule ExRender do
  @moduledoc """
  Documentation for `ExRender`.
  """

  @root "https://api.render.com/v1"

  @spec api_key() :: String.t()
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

  @spec root() :: String.t()
  @doc "Return the root of the API"
  def root, do: @root
end
