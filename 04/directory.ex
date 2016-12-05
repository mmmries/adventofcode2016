defmodule Directory do
  @alphabet ~W( a b c d e f g h i j k l m n o p q r s t u v w x y z )

  def decrypt(encrypted, shift) do
    encrypted
    |> String.split("-")
    |> Enum.map(fn(group) ->
      group
      |> String.split("")
      |> Enum.reject(&( &1 == "" ))
      |> Enum.map(&( shift_letter(&1, shift) ))
      |> Enum.join
    end)
    |> Enum.join(" ")
  end

  def parse(str) do
    [_, name, sector, checksum] = Regex.run(~r{([a-z\-]+)-(\d+)\[(.+)\]}, str)
    sector = String.to_integer(sector)
    computed = compute_checksum(name)
    %{
      name: decrypt(name, sector),
      sector: sector,
      checksum: checksum,
      decoy?: checksum != computed,
    }
  end

  def sum_real_sector_ids(str) do
    str
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&( &1 == "" ))
    |> Enum.map(&parse/1)
    |> Enum.reject(&( &1.decoy? ))
    |> Enum.reduce(0, fn(listing, sum) -> sum + listing.sector end)
  end

  defp compute_checksum(name) do
    name
    |> String.split("")
    |> Enum.reject(&( &1 == "-" || &1 == "" ))
    |> Enum.group_by(&( &1 ))
    |> Enum.map(fn({letter, instances}) -> {-Enum.count(instances), letter} end)
    |> Enum.sort
    |> Enum.take(5)
    |> Enum.map(fn({_count, letter}) -> letter end)
    |> Enum.join
  end

  defp shift_letter(letter, shift) do
    start = Enum.find_index(@alphabet, &( &1 == letter))
    actual = rem(start + shift, Enum.count(@alphabet))
    Enum.at(@alphabet, actual)
  end
end
