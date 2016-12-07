defmodule Ip do
  # Part 1
  def tls?(ip) do
    ip
    |> String.split("")
    |> Enum.chunk(4, 1)
    |> scan_chunks_for_tls(false, false)
  end

  defp scan_chunks_for_tls([], _in_brackets, found_abba), do: found_abba
  defp scan_chunks_for_tls([[a,b,b,a] | rest], in_brackets, _) when a != b do
    case in_brackets do
      true ->
        false #exit early, we found an abba in brackets
      false ->
        scan_chunks_for_tls(rest, in_brackets, true)
    end
  end
  defp scan_chunks_for_tls([["[" | _] | rest], _, found_abba) do
    scan_chunks_for_tls(rest, true, found_abba)
  end
  defp scan_chunks_for_tls([["]" | _ ] | rest], true, found_abba) do
    scan_chunks_for_tls(rest, false, found_abba)
  end
  defp scan_chunks_for_tls([_ | rest], in_brackets, found_abba) do
    scan_chunks_for_tls(rest, in_brackets, found_abba)
  end

  # Part 2
  def ssl?(ip) do
    ip
    |> String.split("")
    |> Enum.chunk(3, 1)
    |> scan_chunks_for_ssl([], [], false)
  end

  defp scan_chunks_for_ssl([], _abas_found, _babs_found, _in_brackets), do: false
  defp scan_chunks_for_ssl([[a,b,a] | rest], abas_found, babs_found, false) when a != b do
    bab = [b,a,b]
    case Enum.member?(babs_found, bab) do
      true -> true
      false ->
        abas_found = [[a,b,a] | abas_found]
        scan_chunks_for_ssl(rest, abas_found, babs_found, false)
    end
  end
  defp scan_chunks_for_ssl([[b,a,b] | rest], abas_found, babs_found, true) when a != b do
    aba = [a, b, a]
    case Enum.member?(abas_found, aba) do
      true -> true
      false ->
        babs_found = [[b,a,b] | babs_found]
        scan_chunks_for_ssl(rest, abas_found, babs_found, true)
    end
  end
  defp scan_chunks_for_ssl([["["|_] | rest], abas_found, babs_found, false) do
    scan_chunks_for_ssl(rest, abas_found, babs_found, true)
  end
  defp scan_chunks_for_ssl([["]"|_] | rest], abas_found, babs_found, true) do
    scan_chunks_for_ssl(rest, abas_found, babs_found, false)
  end
  defp scan_chunks_for_ssl([_ | rest], abas_found, babs_found, in_brackets) do
    scan_chunks_for_ssl(rest, abas_found, babs_found, in_brackets)
  end
end
