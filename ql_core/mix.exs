defmodule QlCore.MixProject do
  use Mix.Project

  def project do
    [
      app: :ql_core,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # Industry Standard: Ensure we check types with Dialyzer to catch logic errors early
      dialyzer: [
        plt_add_apps: [:ex_unit, :mix],
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {QlCore.Application, []}
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
      {:ex_machina, "~> 2.8", only: [:test]},
      {:mox, "~> 1.2", only: [:test]}
    ]
  end
end
