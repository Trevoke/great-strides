defmodule GreatStrides.Mixfile do
  use Mix.Project

  def project do
    [app: :great_strides,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {GreatStrides, []},
     applications: app_list(Mix.env)]
  end

  defp app_list(:dev), do: [:ueberauth_identity, :faker | app_list()]
  defp app_list(_), do: app_list()
  defp app_list(), do:  [:phoenix, :phoenix_html, :cowboy, :logger, :gettext,
                         :phoenix_ecto, :postgrex, :oauth, :ueberauth_google]

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.1.4"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_ecto, "~> 2.0"},
      {:phoenix_html, "~> 2.4"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.9"},
      {:cowboy, "~> 1.0"},
      {:oauth, github: "tim/erlang-oauth"},
      {:ueberauth, "~> 0.2"},
      {:ueberauth_google, "~> 0.2"},
      {:mail, "~> 0.0.4"},
      {:ueberauth_identity, "~> 0.2", only: :dev},
      {:faker, "~> 0.5", only: [:dev, :test]}
    ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
