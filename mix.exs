defmodule ExRender.MixProject do
  use Mix.Project

  @source_url "https://github.com/docJerem/ex_render"
  @version "0.1.0"

  def project do
    [
      app: :ex_render,
      deps: deps(),
      description: description(),
      elixir: "~> 1.16",
      package: package(),
      preferred_cli_env: preferred_cli_env(),
      source_url: @source_url,
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: @version
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

  defp description do
    """
    Render's public REST API to manage your Render services and other resources with basic HTTP requests.

    The API provides programmatic access to many of the same capabilities in the Render Dashboard,
    enabling you to integrate with the platform in your own apps and scripts.
    """
  end

  defp package do
    [
      maintainers: [
        "Jeremie Flandrin"
      ],
      licenses: ["MIT"],
      links: %{
        "Website" => "https://api-docs.render.com/reference/introduction",
        "Github" => @source_url
      }
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
