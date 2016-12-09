defmodule Compress do
  def de(str) do
    expand(str) |> Enum.join("")
  end

  defp expand(str) do
    case Regex.run(~r{(.*?)\((\d+)x(\d+)\)(.*)\Z}, str) do
      [_, prefix,len,repeat,suffix] ->
        len = String.to_integer(len)
        repeat = String.to_integer(repeat)
        chunk = suffix |> String.slice(0..(len-1)) |> List.duplicate(repeat) |> Enum.join("")
        suffix = String.slice(suffix, len..-1)
        [prefix, chunk | expand(suffix)]
      nil ->
        [str]
    end
  end
end
