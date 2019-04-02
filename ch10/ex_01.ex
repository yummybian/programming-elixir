defmodule MyList do
  def all?(list), do: all?(list, fn x -> !!x end)

  def all?([], _), do: true

  def all?([head | tail], fun) do
    if fun.(head) do
      all?(tail, fun)
    else
      false
    end
  end

  def each([], _fun), do: []

  def each([head | tail], fun) do
    [fun.(head) | each(tail, fun)]
  end

  def filter([], _fun), do: []

  def filter([head | tail], fun) do
    if fun.(head) do
      [head | filter(tail, fun)]
    else
      [filter(tail, fun)]
    end
  end

  def split(list, count), do: _split(list, [], count)
  defp _split([], front, _count), do: [Enum.reverse(front), []]
  defp _split(tail, front, 0), do: [Enum.reverse(front), tail]
  defp _split([head | tail], front, count), do: _split(tail, [head | front], count - 1)

  def take(list, n), do: hd(split(list, n))
end

IO.inspect(MyList.all?([]))
IO.inspect(MyList.all?([true, true]))
IO.inspect(MyList.all?([true, false]))
IO.inspect(MyList.all?([4, 5, 6], &(&1 > 3)))

IO.inspect(MyList.each([1, 2, 3], &(&1 + 1)))

IO.inspect(MyList.split([1, 2, 3, 4, 5, 6], 3))

IO.inspect(MyList.take('pragmatic', 6))
