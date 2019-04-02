defmodule Chop do
  def guess(actual, range = low..high) when actual >= low and actual <= high do
    guess = div(high + low, 2)
    IO.puts("Is it #{guess}")
    _guess(actual, guess, range)
  end

  defp _guess(actual, actual, _) do
    IO.puts("Yes, it is #{actual}")
    actual
  end

  defp _guess(actual, guess, _low..high) when actual > guess do
    guess(actual, (guess + 1)..high)
  end

  defp _guess(actual, guess, low.._high) when actual < guess do
    guess(actual, low..(guess - 1))
  end
end

Chop.guess(273, 1..1000)
