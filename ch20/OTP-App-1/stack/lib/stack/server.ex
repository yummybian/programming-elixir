defmodule Stack.Server do
  use GenServer

  alias Stack.Stash

  @server __MODULE__

  #####
  # External API

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: @server)
  end

  def pop() do
    GenServer.call(@server, :pop)
  end

  def push(item) do
    GenServer.cast(@server, {:push, item})
  end

  #####
  # GenServer implement

  def init(_) do
    {:ok, Stash.get()}
  end

  def handle_call(:pop, _from, state) when state == [] do
    raise "Invalid operation: pop on empty stack"
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
    Stash.update(state)
  end
end
