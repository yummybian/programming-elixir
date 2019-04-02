defmodule MyList do
  def span(from, to) when from > to do
    []
  end

  def span(from, to) do
    [from | span(from + 1, to)]
  end
end

n = 40

IO.inspect(
  for x <- MyList.span(2, n), Enum.all?(MyList.span(2, x - 1), &(rem(x, &1) != 0)), do: x
)
