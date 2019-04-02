defmodule MyList do
  def max([head | tail]), do: _max(tail, head)

  defp _max([], max), do: max

  defp _max([head | tail], max) when head >= max do
    _max(tail, head)
  end

  defp _max([head | tail], max) when head < max do
    _max(tail, max)
  end
end

IO.puts(MyList.max([1, 3, 5, 4, 9, 2, 3]))
