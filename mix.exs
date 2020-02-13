defmodule OvoUtils.MixProject do
  use Mix.Project

  def project do
    [
      app: :ovo_utils,
      version: "0.2.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],

      # Docs
      source_url: "https://github.com/ourveryown/ovo-utils",
      docs: [extras: ["README.md"]],
      description: "Common utilities used in Our Very Own Elixir projects.",
      package: package()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:credo, "~> 1.0.0", only: [:dev, :test]},
      {:excoveralls, "~> 0.10", only: :test},
      {:ex_doc, "~> 0.19", only: :dev},
      {:recase, "~> 0.6.0"}
    ]
  end

  def package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ourveryown/ovo-utils"}
    ]
  end
end
