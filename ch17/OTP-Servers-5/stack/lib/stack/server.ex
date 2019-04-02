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

  def handle_call(:pop, _from, state) when state == [] do
    raise "Invalid operation: pop on empty statck"
  end

  def handle_call(:pop, _from, state) do
    [item | tail] = state
    {:reply, item, tail}
  end

  def handle_cast({:push, item}, _state) when not is_number(item) do
    raise "Invalid operation: item must be valid number"
  end

  def handle_cast({:push, item}, state) do
    {:noreply, [item | state]}
  end

  def terminate(reason, state) do
    IO.puts("reason: #{inspect(reason)}\n
    state: #{inspect(state)}")
  end
end
