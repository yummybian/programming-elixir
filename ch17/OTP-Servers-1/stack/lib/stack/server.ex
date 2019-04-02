defmodule Stack.Server do
  use GenServer

  def init(state) do
    {:ok, state}
  end

  def handle_call(:pop, _from, [item | tail]) do
    {:reply, item, tail}
  end
end
