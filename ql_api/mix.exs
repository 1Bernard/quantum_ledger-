defmodule QlApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :ql_api,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {QlApi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:bandit, "~> 1.5"},
      {:jason, "~> 1.2"},
      {:hammer, "~> 7.1"}, # Rate limiting for API protection

      # Path dependency to QLCore (The Brain)
      {:ql_core, path: "../ql_core"}
    ]
  end
end
