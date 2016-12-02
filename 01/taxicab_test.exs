Code.require_file("taxicab.ex")

ExUnit.start()

defmodule TaxicabTest do
  use ExUnit.Case, async: true

  test "two turns" do
    distance = "R2, L3" |> Taxicab.follow_directions |> Taxicab.distance_to
    assert distance == 5
  end

  test "doubling back" do
    distance = "R2, R2, R2" |> Taxicab.follow_directions |> Taxicab.distance_to
    assert distance == 2
  end

  test "wandering" do
    distance = "R5, L5, R5, R3" |> Taxicab.follow_directions |> Taxicab.distance_to
    assert distance == 12
  end

  test "first repeated location" do
    first_repeat = "R8, R4, R4, R8" |> Taxicab.follow_directions_until_first_repeat
    distance = Taxicab.distance_to(first_repeat)
    assert first_repeat.x == 4
    assert first_repeat.y == 0
    assert distance == 4
  end
end
