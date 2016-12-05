defmodule AdvancedBuster do
  def code_for(door) do
    search_for_digits(door, 0, [nil, nil, nil, nil, nil, nil, nil, nil])
  end

  defp md5(string), do: :crypto.hash(:md5, string) |> Base.encode16

  defp search_for_digits(door, number, characters) do
    case Enum.member?(characters, nil) do
      true ->
        hash = md5("#{door}#{number}")
        case String.starts_with?(hash, "00000") do
          true ->
            position = hash |> String.at(5) |> String.to_integer(16)
            character = hash |> String.at(6)
            characters = update_character_at(characters, position, character)
            search_for_digits(door, number + 1, characters)
          false ->
            search_for_digits(door, number + 1, characters)
        end
      false ->
        characters |> Enum.join |> String.downcase
    end
  end

  defp update_character_at(characters, position, character) when position in [0,1,2,3,4,5,6,7] do
    case Enum.at(characters, position) do
      nil ->
        characters = List.replace_at(characters, position, character)
        IO.puts "\t\tfound number for #{position} :: #{inspect characters}"
        characters
      _ ->
        characters
    end
  end
  defp update_character_at(characters, _, _), do: characters
end
