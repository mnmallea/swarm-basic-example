defmodule Distribucion.Dummy do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, nil, name: name)
  end

  def ping(pid) do
    GenServer.call(pid, :ping)
  end

  @impl true
  def init(_) do
    {:ok, nil}
  end

  @impl true
  def handle_call(:ping, _from, _payload) do
    {:reply, "pong", nil}
  end
end
