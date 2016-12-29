Code.require_file("vm.ex")

IO.puts "---- executing instructions and looking for register a ----"
state = "input.txt" |> File.read! |> Vm.run
IO.puts "\ta: #{state[:a]}"
