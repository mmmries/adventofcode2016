defmodule Taxicab do
  def distance_to(%{x: x, y: y}), do: abs(x) + abs(y)

  def follow_directions(directions) do
    parsed = parse_directions(directions)
    position = %{x: 0, y: 0, heading: :north}
    Enum.reduce(parsed, position, &update_position/2)
  end

  def follow_directions_until_first_repeat(directions) do
    parsed = parse_directions(directions)
    position = %{x: 0, y: 0, heading: :north}
    parsed
    |> Enum.reduce([position], &record_positions/2)
    |> first_repeat
  end

  defp first_repeat([first | rest]) do
    first_repeat(first, rest, [])
  end
  defp first_repeat(_position, [], _past_directions), do: nil
  defp first_repeat(position, [next | rest], past_directions) do
    case Enum.filter(past_directions, &( &1.x == position.x && &1.y == position.y )) do
      [] ->
        first_repeat(next, rest, [position | past_directions])
      _ ->
        position
    end
  end

  defp parse_direction("R"<>distance), do: {:right, String.to_integer(distance)}
  defp parse_direction("L"<>distance), do: {:left, String.to_integer(distance)}

  defp parse_directions(str) do
    str
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_direction/1)
  end

  defp path_to({direction, distance}, %{x: x, y: y, heading: heading}) do
    new_heading = turn(heading, direction)
    Enum.map(1..distance, fn(dist) ->
      {new_x, new_y} = move(x, y, new_heading, dist)
      %{x: new_x, y: new_y, heading: new_heading}
    end)
  end

  defp move(x, y, :north, distance), do: {x, y + distance}
  defp move(x, y, :east, distance), do: {x + distance, y}
  defp move(x, y, :south, distance), do: {x, y - distance}
  defp move(x, y, :west, distance), do: {x - distance, y}

  defp record_positions(direction, list) do
    position = List.last(list)
    list ++ path_to(direction, position)
  end

  defp turn(:north, :right), do: :east
  defp turn(:north, :left), do: :west
  defp turn(:east,  :right), do: :south
  defp turn(:east,  :left), do: :north
  defp turn(:south, :right), do: :west
  defp turn(:south, :left), do: :east
  defp turn(:west,  :right), do: :north
  defp turn(:west,  :left), do: :south

  defp update_position(action, position) do
    path_to(action, position) |> List.last
  end
end
