defmodule ExRender.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_render,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: preferred_cli_env()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExRender.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7"},
      {:doctor, "~> 0.21.0", only: :dev},
      {:exconstructor, "~> 1.2"},
      {:excoveralls, "~> 0.18.1"},
      {:mix_audit, "~> 2.1", only: [:dev, :test], runtime: false},
      {:mix_test_watch, "~> 1.2", only: :dev},
      {:mox, "~> 1.0", only: :test},
      {:req, "~> 0.4.14"},
      {:sobelow, "~> 0.13.0"}
    ]
  end

  defp preferred_cli_env do
    [
      coveralls: :test,
      "coveralls.detail": :test,
      "coveralls.post": :test,
      "coveralls.html": :test,
      "coveralls.cobertura": :test
    ]
  end
end
