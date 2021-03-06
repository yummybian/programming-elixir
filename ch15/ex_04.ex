defmodule Processes do
  import :timer, only: [sleep: 1]

  def run do
    Process.flag(:trap_exit, true)
    _pid = spawn_link(Processes, :send_message_to, [self()])
    sleep(500)
    receive_messages()
  end

  def send_message_to(parent) do
    send(parent, "Boom!")
    raise RuntimeError, message: "bye"
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
