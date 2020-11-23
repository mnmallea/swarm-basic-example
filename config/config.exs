use Mix.Config

config :swarm,
  distribution_strategy: Swarm.Distribution.Ring
