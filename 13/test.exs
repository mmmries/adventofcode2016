Code.require_file("cubicle.ex")

ExUnit.start()

defmodule CubicleTest do
  use ExUnit.Case, async: true

  test "it knows which locations are walls and which are open" do
    assert Cubicle.open?({0,0}, 10) == true
    assert Cubicle.open?({1,0}, 10) == false
    assert Cubicle.open?({0,1}, 10) == true
    assert Cubicle.open?({1,1}, 10) == true
    assert Cubicle.open?({2,1}, 10) == false
  end

  test "it can find the minimum number of steps to a given destination" do
    assert Cubicle.shortest_distance_between({1,1},{1,1},{0,0},{9,6},10) == 0
    assert Cubicle.shortest_distance_between({1,1},{7,4},{0,0},{9,6},10) == 11
  end

  test "it can find the number of unique locations within a given distance" do
    assert Cubicle.count_unique_locations({1,1}, {0,0}, 3, 10) == 6
  end
end
