defmodule MyList do
  def mapsum(list, func) do
    _mapsum(list, func, 0)
  end

  defp _mapsum([], _func, sum), do: sum
  defp _mapsum([head | tail], func, sum), do: _mapsum(tail, func, sum + func.(head))
end

IO.puts(MyList.mapsum([1, 2, 3], &(&1 * &1)))
