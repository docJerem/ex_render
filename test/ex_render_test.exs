defmodule ExRenderTest do
  use ExUnit.Case
  doctest ExRender

  assert_raise RuntimeError, ~r/Missing API key/, fn ->
    ExRender.api_key()
  end

  test "Return the root of the API" do
    assert ExRender.root() == "https://api.render.com/v1"
  end
end
