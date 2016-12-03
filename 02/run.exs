Code.require_file("keypad.ex")
Code.require_file("weird_keypad.ex")

IO.puts "---- Simple ----"
IO.puts "\tcode = #{Keypad.code(File.read!("simple.txt"))}"
IO.puts "---- Complex ----"
IO.puts "\tcode = #{WeirdKeypad.code(File.read!("simple.txt"))}"
