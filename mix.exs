defmodule AOC2020.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc_2020,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {AOC2020, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
  end
end
