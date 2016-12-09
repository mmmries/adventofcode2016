Code.require_file("compress.ex")
Code.require_file("compress_v2.ex")

IO.puts "-------------------------"
size = "input.txt" |> File.read! |> Compress.de |> String.length
IO.puts "input.txt decompresses to #{size}"

IO.puts "-------------------------"
size = "input.txt" |> File.read! |> CompressV2.desize
IO.puts "input.txt decompresses (with v2) to #{size}"
