defmodule Ring do
  # 2 seconds
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :handler, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send(:global.whereis_name(@name), {:register, client_pid})
  end

  def handler(clients) do
    receive do
      {:register, pid} ->
        IO.puts("registering #{inspect(pid)}")
        handler([pid | clients])
        # handler(client ++ [pid])
        send()
    after
      @interval ->
        IO.puts("tick")

        [head | tail] = [clients]
        send(head, {:tick})

        handler(tail ++ [head])
    end
  end
end

defmodule Client do
  def join do
    pid = spawn(__MODULE__, :receiver, [[]])
    Ring.register(pid)
  end

  defp send_tick(next_client) do
    if next_client do
      send(next_client, {:tick})
    end
  end

  def receiver(next_client) do
    receive do
      {:update, next_client} ->
        receiver(next_client)

      {:tick} ->
        IO.puts("ticks on node #{inspect(self)}")
        send_tick(next_client)
        receiver(next_client)
    end
  end
end
