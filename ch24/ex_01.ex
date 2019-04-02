defmodule Cypher do
  def caesar([], _n), do: []

  def caesar([head | tail], n) when head + n <= ?z do
    [head + n | caesar(tail, n)]
  end

  def caesar([head | tail], n) do
    [head + n - 26 | caesar(tail, n)]
  end
end

defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: List do
  def encrypt(string, shift) do
    Cypher.caesar(string, shift)
  end

  def rot13(string) do
    Cypher.caesar(string, 13)
  end
end

defimpl Caesar, for: BitString do
  def encrypt(string, shift) do
    string
    |> to_charlist()
    |> Cypher.caesar(shift)
    |> to_string()
  end

  def rot13(string) do
    string
    |> to_charlist()
    |> Cypher.caesar(13)
    |> to_string()
  end
end

IO.inspect(Caesar.encrypt("Hello", 0))
IO.inspect(Caesar.encrypt('Hello', 0))

IO.inspect(Caesar.encrypt("Hello", 1))
IO.inspect(Caesar.encrypt('Hello', 1))

IO.inspect(Caesar.rot13("Hello"))
IO.inspect(Caesar.rot13('Hello'))
