defmodule Processes do
  import :timer, only: [sleep: 1]

  def run do
    # Process.flag(:trap_exit, true)
    _res = spawn_monitor(Processes, :send_message_to, [self()])
    sleep(500)
    receive_messages()
  end

  def send_message_to(parent) do
    send(parent, "Boom!")
    exit("bye")
  end

  def receive_messages do
    receive do
      msg ->
        IO.puts("#{inspect(msg)}")
        receive_messages()
    after
      500 ->
        IO.puts("timeout")
    end
  end
end

Processes.run()
