defmodule Distribucion.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [
      example: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]

    children = [
      {Cluster.Supervisor, [topologies, [name: Distribucion.ClusterSupervisor]]},
      Distribucion.Supervisor
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: ApplicationSupervisor)
  end
end
