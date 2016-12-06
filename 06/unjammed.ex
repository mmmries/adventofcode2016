defmodule Unjammed do
  def by_common_position(input) do
    character_grid = string_to_character_grid(input)
    occurences_by_column = character_grid |> Enum.at(0) |> Enum.map(fn(_) -> %{} end)
    count_letter_occurences(character_grid, occurences_by_column)
    |> pick_winners_and_join(&List.last/1)
  end

  def by_least_common(input) do
    character_grid = string_to_character_grid(input)
    occurences_by_column = character_grid |> Enum.at(0) |> Enum.map(fn(_) -> %{} end)
    count_letter_occurences(character_grid, occurences_by_column)
    |> pick_winners_and_join(&hd/1)
  end

  defp count_letter_occurences([], occurences), do: occurences
  defp count_letter_occurences([characters | rest], occurences) do
    occurences = occurences
                 |> Enum.zip(characters)
                 |> Enum.map(&update_counts/1)
    count_letter_occurences(rest, occurences)
  end

  defp pick_winners_and_join(counts_by_column, picker_fun) do
    counts_by_column
    |> Enum.map(fn(counts) ->
      counts |> Enum.sort_by(&( elem(&1, 1) )) |> (picker_fun).() |> elem(0)
    end)
    |> Enum.join("")
  end

  defp string_to_character_grid(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&( &1 == "" ))
    |> Enum.map(&( String.split(&1, "") ))
  end

  defp update_counts({counts, character}) do
    new_count = case counts[character] do
                  nil -> 1
                  count -> count + 1
                end
    Map.put(counts, character, new_count)
  end
end
