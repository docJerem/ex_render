defmodule ExRender.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_render,
      name: "Render API",
      description: """
      Render's public REST API to manage your Render services and other resources with basic HTTP requests.

      The API provides programmatic access to many of the same capabilities in the Render Dashboard,
      enabling you to integrate with the platform in your own apps and scripts.
      """,
      package: package(),
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: preferred_cli_env()
    ]
  end

  def package do
    [
      licences: ["MIT"],
      links: %{
        "Website" => "https://api-docs.render.com/reference/introduction",
        "Github" => "https://github.com/docJerem/ex_render"
      }
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7"},
      {:doctor, "~> 0.21.0", only: :dev},
      {:exconstructor, "~> 1.2"},
      {:excoveralls, "~> 0.18.1"},
      {:ex_doc, "~> 0.33.0", only: :dev, runtime: false},
      {:mix_audit, "~> 2.1", only: [:dev, :test], runtime: false},
      {:mix_test_watch, "~> 1.2", only: [:dev, :test]},
      {:mox, "~> 1.0", only: :test},
      {:plug, "~> 1.16"},
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
