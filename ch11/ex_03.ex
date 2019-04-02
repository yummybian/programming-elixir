defmodule MyString do
  def calculate(experssion) do
    {n1, rest} = parse_number(experssion)
    rest = skip_spaces(rest)
    {op, rest} = parse_operator(rest)
    rest = skip_spaces(rest)
    {n2, []} = parse_number(rest)
    op.(n1, n2)
  end

  defp parse_number(expression), do: _parse_number({0, expression})

  defp _parse_number({value, [digit | rest]}) when digit in ?0..?9 do
    _parse_number({value * 10 + digit - ?0, rest})
  end

  defp _parse_number(result), do: result

  defp skip_spaces([?\s | rest]), do: skip_spaces(rest)
  defp skip_spaces(result), do: result

  defp parse_operator([?+ | rest]), do: {fn a, b -> a + b end, rest}
  defp parse_operator([?- | rest]), do: {fn a, b -> a - b end, rest}
  defp parse_operator([?* | rest]), do: {fn a, b -> a * b end, rest}
  defp parse_operator([?/ | rest]), do: {fn a, b -> a / b end, rest}
end

MyString.calculate('123+27') |> IO.inspect()
