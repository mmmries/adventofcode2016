Code.require_file("taxicab.ex")

IO.puts "----simple puzzle----"
distance = "simple.txt" |> File.read! |> Taxicab.follow_directions |> Taxicab.distance_to
IO.puts "\tdistance: #{distance}"
