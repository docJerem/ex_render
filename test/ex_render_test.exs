defmodule ExRenderTest do
  use ExUnit.Case
  doctest ExRender

  assert_raise RuntimeError, ~r/Missing API key/, fn ->
    ExRender.api_key()
  end
end
