defmodule MyString do
  def center(list) do
    list
    |> Enum.map_reduce(0, &accumulate_max_length(&1, &2))
    |> center_strings_in_field
    |> Enum.each(&IO.puts/1)
  end

  def center_strings_in_field({strings, field_width}) do
    strings
    |> Enum.map(&center_one_string(&1, field_width))
  end

  defp center_one_string(string, field_width) do
    String.duplicate(" ", div(field_width - String.length(string), 2)) <> string
  end

  defp accumulate_max_length(string, max_length_so_far) do
    {string,
     String.length(string)
     |> max(max_length_so_far)}
  end
end

list = ["cat", "zebra", "elephant"]
list |> MyString.center()
