defmodule Buster do
  def code_for(door) do
    search_for_digits(door, 0, [])
  end

  defp md5(string), do: :crypto.hash(:md5, string) |> Base.encode16

  defp search_for_digits(_door, _number, characters) when length(characters) >= 8, do: Enum.join(characters) |> String.downcase
  defp search_for_digits(door, number, characters) do
    hash = md5("#{door}#{number}")
    case String.starts_with?(hash, "00000") do
      true ->
        IO.puts "found #{hash} for number #{number}"
        character = hash |> String.at(5)
        characters = characters ++ [character]
        search_for_digits(door, number + 1, characters)
      false ->
        search_for_digits(door, number + 1, characters)
    end
  end
end
