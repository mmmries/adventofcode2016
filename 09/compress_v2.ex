defmodule CompressV2 do
  def desize(str) do
    case Regex.run(~r{(.*?)\((\d+)x(\d+)\)(.*)\Z}, str) do
      [_, prefix,len,repeat,suffix] ->
        len = String.to_integer(len)
        repeat = String.to_integer(repeat)
        chunk = suffix |> String.slice(0..(len-1)) |> desize
        suffix = String.slice(suffix, len..-1)
        String.length(prefix) + (chunk * repeat) + desize(suffix)
      nil ->
        String.length(str)
    end
  end
end
