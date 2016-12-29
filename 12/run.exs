Code.require_file("vm.ex")

IO.puts "---- executing instructions and looking for register a ----"
state = "input.txt" |> File.read! |> Vm.run
IO.puts "\ta: #{state[:a]}"

IO.puts "---- executing instructions with c set to 1 ----"
state = Vm.init |> Map.put(:c, 1)
state = "input.txt" |> File.read! |> Vm.run(state)
IO.puts "\ta: #{state[:a]}"
