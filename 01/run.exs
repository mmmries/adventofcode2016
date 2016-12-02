Code.require_file("taxicab.ex")

IO.puts "----simple puzzle----"
distance = "simple.txt" |> File.read! |> Taxicab.follow_directions |> Taxicab.distance_to
IO.puts "\tdistance: #{distance}"

IO.puts "----complex puzzle----"
distance = "simple.txt" |> File.read! |> Taxicab.follow_directions_until_first_repeat |> Taxicab.distance_to
IO.puts "\tdistance to first location repeated: #{distance}"
