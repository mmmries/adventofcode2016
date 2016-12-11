Code.require_file("assembler.ex")

IO.puts "---- looking for which bot compared 17 and 61 ----"
assembled = "input.txt" |> File.read! |> Assembler.run
IO.puts "\tbot #{Assembler.who_compared(assembled, {17,61})}"

IO.puts "---- Multiplying outputs 0, 1 and 2 ----"
[a, b, c] = ["0","1","2"] |> Enum.map(&( Assembler.contents_of_bin(assembled, &1) ))
IO.puts "\tresult = #{a * b * c}"
