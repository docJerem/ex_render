defmodule ExRender do
  @moduledoc """
  Documentation for `ExRender`.
  """

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
end
