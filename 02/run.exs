Code.require_file("keypad.ex")

IO.puts "---- Simple ----"
IO.puts "\tcode = #{Keypad.code(File.read!("simple.txt"))}"
