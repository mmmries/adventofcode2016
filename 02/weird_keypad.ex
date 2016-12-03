defmodule WeirdKeypad do
  def code(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> instructions_to_code("5", [])
  end

  def next_key(current, moves) do
    Enum.reduce(moves, current, &( advance(&2, &1) ))
  end

  defp advance("1", "U"), do: "1"
  defp advance("1", "D"), do: "3"
  defp advance("1", "L"), do: "1"
  defp advance("1", "R"), do: "1"
  defp advance("2", "U"), do: "2"
  defp advance("2", "D"), do: "6"
  defp advance("2", "L"), do: "2"
  defp advance("2", "R"), do: "3"
  defp advance("3", "U"), do: "1"
  defp advance("3", "D"), do: "7"
  defp advance("3", "L"), do: "2"
  defp advance("3", "R"), do: "4"
  defp advance("4", "U"), do: "4"
  defp advance("4", "D"), do: "8"
  defp advance("4", "L"), do: "7"
  defp advance("4", "R"), do: "4"
  defp advance("5", "U"), do: "5"
  defp advance("5", "D"), do: "5"
  defp advance("5", "L"), do: "5"
  defp advance("5", "R"), do: "6"
  defp advance("6", "U"), do: "2"
  defp advance("6", "D"), do: "A"
  defp advance("6", "L"), do: "5"
  defp advance("6", "R"), do: "7"
  defp advance("7", "U"), do: "3"
  defp advance("7", "D"), do: "B"
  defp advance("7", "L"), do: "6"
  defp advance("7", "R"), do: "8"
  defp advance("8", "U"), do: "4"
  defp advance("8", "D"), do: "C"
  defp advance("8", "L"), do: "7"
  defp advance("8", "R"), do: "9"
  defp advance("9", "U"), do: "9"
  defp advance("9", "D"), do: "9"
  defp advance("9", "L"), do: "8"
  defp advance("9", "R"), do: "9"
  defp advance("A", "U"), do: "6"
  defp advance("A", "D"), do: "A"
  defp advance("A", "L"), do: "A"
  defp advance("A", "R"), do: "B"
  defp advance("B", "U"), do: "7"
  defp advance("B", "D"), do: "D"
  defp advance("B", "L"), do: "A"
  defp advance("B", "R"), do: "C"
  defp advance("C", "U"), do: "8"
  defp advance("C", "D"), do: "C"
  defp advance("C", "L"), do: "B"
  defp advance("C", "R"), do: "C"
  defp advance("D", "U"), do: "B"
  defp advance("D", "D"), do: "D"
  defp advance("D", "L"), do: "D"
  defp advance("D", "R"), do: "D"

  defp instructions_to_code([], _, code), do: Enum.join(code, "")
  defp instructions_to_code([instruction | rest], current, code) do
    moves = String.split(instruction, "", trim: true)
    next = next_key(current, moves)
    instructions_to_code(rest, next, code ++ [next])
  end
end
