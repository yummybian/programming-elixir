defmodule Processes do
  def token do
    receive do
      {sender, msg} ->
        send(sender, {:ok, "token: #{msg}"})
        token()
    end
  end
end

pid1 = spawn(Processes, :token, [])
pid2 = spawn(Processes, :token, [])

send(pid1, {self(), "fred"})

receive do
  {:ok, msg} ->
    IO.puts(msg)
end

send(pid2, {self(), "betty"})

receive do
  {:ok, msg} ->
    IO.puts(msg)
end
