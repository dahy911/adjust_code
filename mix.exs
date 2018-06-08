defmodule Adjust.Mixfile do
  use Mix.Project

  def project do
    [
      app: :adjust,
      version: "0.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Adjust, []},
      applications: [:logger, :postgrex, :ecto, :cowboy, :plug, :poison]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 2.1"},
      {:geo, "~> 1.3"},
      {:cowboy, "~> 1.0.4"},
      {:plug, "~> 1.1.0"},
      {:postgrex, "~> 0.13.3"},
      {:poison, "~> 3.0"},
      {:csvlixir, "~> 2.0.3"},
      {:csv, "~> 2.0.0"}
    ]
  end
end
