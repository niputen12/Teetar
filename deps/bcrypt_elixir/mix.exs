defmodule BcryptElixir.Mixfile do
  use Mix.Project

  @version "0.12.1"

  @description """
  Bcrypt password hashing algorithm for Elixir
  """

  def project do
    [
      app: :bcrypt_elixir,
      version: @version,
      elixir: "~> 1.4",
      start_permanent: Mix.env == :prod,
      compilers: [:elixir_make] ++ Mix.compilers,
      description: @description,
      package: package(),
      source_url: "https://github.com/riverrun/bcrypt_elixir",
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  defp deps do
    [
      {:elixir_make, "~> 0.4", runtime: false},
      {:earmark, "~> 1.2", only: :dev},
      {:ex_doc,  "~> 0.16", only: :dev}
    ]
  end

  defp package do
    [
      files: ["lib", "c_src", "mix.exs", "Makefile*", "README.md"],
      maintainers: ["David Whitlock"],
      licenses: ["BSD"],
      links: %{"GitHub" => "https://github.com/riverrun/bcrypt_elixir",
        "Docs" => "http://hexdocs.pm/bcrypt_elixir"}
    ]
  end
end
