defmodule Ip do
  def tls?(ip) do
    ip
    |> String.split("")
    |> Enum.chunk(4, 1)
    |> scan_chunks(false, false)
  end

  defp scan_chunks([], _in_brackets, found_abba), do: found_abba
  defp scan_chunks([[a,b,b,a] | rest], in_brackets, _) when a != b do
    case in_brackets do
      true ->
        false #exit early, we found an abba in brackets
      false ->
        scan_chunks(rest, in_brackets, true)
    end
  end
  defp scan_chunks([["[" | _] | rest], _, found_abba) do
    scan_chunks(rest, true, found_abba)
  end
  defp scan_chunks([["]" | _ ] | rest], true, found_abba) do
    scan_chunks(rest, false, found_abba)
  end
  defp scan_chunks([_ | rest], in_brackets, found_abba) do
    scan_chunks(rest, in_brackets, found_abba)
  end
end
