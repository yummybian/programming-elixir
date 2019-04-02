defmodule Stack.Server do
  use GenServer

  #####
  # External API

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  #####
  # GenServer implement

  def init(state) do
    {:ok, state}
  end

  def handle_call(:pop, _from, state) do
    [item | tail] = state
    {:reply, item, tail}
  end

  def handle_cast({:push, item}, state) do
    {:noreply, [item | state]}
  end
end
