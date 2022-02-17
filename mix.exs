defmodule Overpex.Mixfile do
  use Mix.Project

  def project do
    [app: :overpex,
     version: "0.3.1",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: description(),
     package: package(),
     test_coverage: [tool: ExCoveralls],
     name: "Overpex",
     source_url: "https://github.com/brunoasantos/overpex",
     docs: [main: "Overpex",
            extras: ["README.md"]]]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
	{:httpoison, "~> 0.11.0"},
     {:sweet_xml, "~> 0.6.5"},
     {:poison, "~> 3.1.0"},
     {:ex_doc, "~> 0.15", only: :dev, runtime: false},
     {:exvcr, "~> 0.8", only: :test},
     {:excoveralls, "~> 0.6", only: :test},
     {:mock, "~> 0.2", only: :test},
      {:credo, "~> 1.4", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false}
	 ]
  end

  defp description do
    """
    Simple wrapper for the Overpass API
    """
  end

  defp package do
    [name: :overpex,
     maintainers: ["Bruno Santos"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/brunoasantos/overpex",
              "Docs" => "https://hexdocs.pm/overpex"}]
  end
end
