defmodule ElixirDni.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_dni,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: "Package for validating Spanish id numbers",
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
   [
    files: ["lib", "mix.exs", "README.md"],
    maintainers: ["Nevada James Start"],
    licenses: ["MIT"],
    links: %{"GitHub" => "https://github.com/nevadajames/elixir_dni",
             "Docs" => "http://hexdocs.pm/elixir_dni/"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.11", only: :dev},
      {:earmark, "~> 0.1", only: :dev}
    ]
  end
end
