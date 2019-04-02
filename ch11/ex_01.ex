defmodule MyString do
  # def is_ascii(s), do: Enum.all?(s, fn x -> x >= ?\s and x <= ?~ end)
  def is_ascii(s), do: Enum.all?(s, fn x -> x in ? ..?~ end)
end

IO.inspect(MyString.is_ascii('cat!'))
