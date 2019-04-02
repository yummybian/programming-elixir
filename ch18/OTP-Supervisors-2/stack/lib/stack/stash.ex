defmodule Stack.Stash do
  use GenServer

  @stash __MODULE__

  #####
  # External API

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: @stash)
  end

  def get() do
    GenServer.call(@stash, {:get})
  end

  def update(state) do
    GenServer.cast(@stash, {:update, state})
  end

  #####
  # Server Implement

  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_call({:get}, _form, current_state) do
    {:reply, current_state, current_state}
  end

  def handle_cast({:update, state}, _current_state) do
    {:noreply, state}
  end
end
