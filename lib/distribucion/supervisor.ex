defmodule Distribucion.Supervisor do
  use DynamicSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def register(worker_name) do
    IO.puts("Register")
    {:ok, pid} = DynamicSupervisor.start_child(__MODULE__, worker_name)
    IO.puts("Registered")
    {:ok, pid}
  end
end
