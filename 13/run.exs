Code.require_file("cubicle.ex")

IO.puts "looking for shortest path to 31,39 with key 1352"
shortest = Cubicle.shortest_distance_between({1,1}, {31,39}, {0,0}, {40,50}, 1352)
IO.puts "\tdistance = #{inspect shortest}"

IO.puts "finding how many unique locations I can get to within 50 moves with key 1352"
IO.puts "\tcount = #{Cubicle.count_unique_locations({1,1}, {0,0}, 50, 1352)}"
