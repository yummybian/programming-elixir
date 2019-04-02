defmodule MyList do
  def flatten([]), do: []
  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)
  def flatten(head), do: [head]
end

IO.inspect(MyList.flatten([1, [2, 3, [4]], 5, [[[6]]]]))
