Code.require_file("directory.ex")

IO.puts "---- Summing Sectors ----"
str = File.read!("input.txt")
sum = Directory.sum_real_sector_ids(str)
IO.puts"\treal sectors sum to: #{sum}"
