defmodule Distribucion.DummyWorker do
  use GenServer

  def create(name) do
    {:ok, pid} = Swarm.register_name(name, Distribucion.Supervisor, :register, [__MODULE__])
    Swarm.join(:dummies, pid)
    {:ok, pid}
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def ping(pid) do
    GenServer.call(via_swarm(pid), :ping)
  end

  def prepend(pid, element) do
    GenServer.call(via_swarm(pid), {:prepend, element})
  end

  def get_all(pid) do
    GenServer.call(via_swarm(pid), :get_all)
  end

  @impl true
  def init(_) do
    {:ok, []}
  end

  @impl true
  def handle_call(:ping, from, state) do
    IO.puts("Received ping from #{inspect(from)}")
    {:reply, "pong", state}
  end

  @impl true
  def handle_call({:prepend, element}, _from, state) do
    {:reply, :ok, [element | state]}
  end

  defp via_swarm(name) do
    {:via, :swarm, name}
  end
end
