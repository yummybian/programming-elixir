defmodule MyString do
  def center(strings) do
    strings
    |> Enum.map_reduce(0, &accumulate_max_length(&1, &2))
    |> center_strings_in_field
    |> Enum.each(&IO.puts(&1))
  end

  defp accumulate_max_length(string, max_length_so_far) do
    length = String.length(string)
    {string, max(length, max_length_so_far)}
  end

  defp center_strings_in_field({strings, field_width}) do
    strings |> Enum.map(&center_one_string(field_width, &1))
  end

  defp center_one_string(field_width, string) do
    String.duplicate(" ", div(field_width - String.length(string), 2)) <> string
  end
end

IO.inspect(MyString.center(["cat", "zebra", "elephant"]))
