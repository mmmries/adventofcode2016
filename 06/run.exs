Code.require_file("unjammed.ex")

IO.puts "---- Unjamming Signal by Letter Frequency ----"
IO.puts "\tfound: #{Unjammed.by_common_position(File.read!("input.txt"))}"

IO.puts "---- Unjamming Signal by Least Common Letter ----"
IO.puts "\tfound: #{Unjammed.by_least_common(File.read!("input.txt"))}"
