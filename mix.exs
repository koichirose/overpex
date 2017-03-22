defmodule Overpex.Mixfile do
  use Mix.Project

  def project do
    [app: :overpex,
     version: "0.1.1",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     name: "Overpex",
     source_url: "https://github.com/brunoasantos/overpex",
     docs: [main: "Overpex",
            extras: ["README.md"]]]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:httpoison, "~> 0.11.0"},
     {:sweet_xml, "~> 0.6.5"},
     {:poison, "~> 3.1.0"},
     {:ex_doc, "~> 0.15", only: :dev, runtime: false},
     {:mock, "~> 0.2", only: :test}]
  end
end
