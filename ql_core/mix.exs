defmodule QLCore.MixProject do
  use Mix.Project

  def project do
    [
      app: :ql_core,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      # Industry Standard: Ensure we check types with Dialyzer to catch logic errors early
      dialyzer: [
        plt_add_apps: [:ex_unit, :mix],
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      aliases: aliases()
    ]
  end

  # Specifies which paths to compile per environment.
  # We include "test/support" in :test so that DataCase is available to White-Bread.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {QLCore.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # --- ES/CQRS Infrastructure ---
      {:commanded, "~> 1.4"},
      {:commanded_eventstore_adapter, "~> 1.4"},
      # The bridge between Events and Read Model
      {:commanded_ecto_projections, "~> 1.4"},
      {:eventstore, "~> 1.4"},
      {:jason, "~> 1.2"},
      {:phoenix, "~> 1.8.1"},

      # --- Financial Precision & ID handling ---
      {:decimal, "~> 2.3"},
      {:uuidv7, "~> 1.0"},

      # --- Background Processing (Retries & Side-effects) ---
      {:oban, "~> 2.20"},

      # --- Quality Assurance & Linting (CI/CD Gates) ---
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.14.1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev], runtime: false},

      # --- Testing Frameworks ---
      {:white_bread, "~> 4.5", only: [:test]},
      {:gherkin, "~> 1.4.0", only: :test, override: true},
      {:ex_machina, "~> 2.8", only: [:test]},
      {:mox, "~> 1.2", only: [:test]}
    ]
  end

  defp aliases do
    [
      # Ensures ExUnit is started before running WhiteBread
      "test.features": ["run -e 'ExUnit.start(autorun: false)'", "white_bread.run"]
    ]
  end
end
