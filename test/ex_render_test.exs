defmodule ExRenderTest do
  use ExUnit.Case
  doctest ExRender

  test "You need to set an API key" do
    Application.put_env(:ex_render, :api_key, nil)

    assert_raise RuntimeError, ~r/Missing API key/, fn ->
      ExRender.api_key()
    end

    Application.put_env(:ex_render, :api_key, "rnd_test")
  end

  test "Return the root of the API" do
    assert ExRender.root() == "https://api.render.com/v1"
  end
end
