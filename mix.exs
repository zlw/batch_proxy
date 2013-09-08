defmodule BatchProxy.Mixfile do
  use Mix.Project

  def project do
    [ app: :batch_proxy,
      version: "0.0.1",
      elixir: "~> 0.10.2",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [ 
      { :jsex,      "~> 0.2",   github: "talentdeficit/jsex"  },
      { :httpotion, "~> 0.2.2", github: "myfreeweb/httpotion" }
    ]
  end
end
