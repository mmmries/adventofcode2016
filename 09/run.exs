Code.require_file("compress.ex")

IO.puts "-------------------------"
size = "input.txt" |> File.read! |> Compress.de |> String.length
IO.puts "input.txt decompresses to #{size}"

