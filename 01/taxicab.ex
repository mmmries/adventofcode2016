defmodule Taxicab do
  def distance_to(%{x: x, y: y}), do: abs(x) + abs(y)

  def follow_directions(directions) do
    parsed = parse_directions(directions)
    position = %{x: 0, y: 0, heading: :north}
    Enum.reduce(parsed, position, &update_position/2)
  end

  defp parse_direction("R"<>distance), do: {:right, String.to_integer(distance)}
  defp parse_direction("L"<>distance), do: {:left, String.to_integer(distance)}

  defp parse_directions(str) do
    str
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_direction/1)
  end

  defp move(x, y, :north, distance), do: {x, y + distance}
  defp move(x, y, :east, distance), do: {x + distance, y}
  defp move(x, y, :south, distance), do: {x, y - distance}
  defp move(x, y, :west, distance), do: {x - distance, y}

  defp turn(:north, :right), do: :east
  defp turn(:north, :left), do: :west
  defp turn(:east,  :right), do: :south
  defp turn(:east,  :left), do: :north
  defp turn(:south, :right), do: :west
  defp turn(:south, :left), do: :east
  defp turn(:west,  :right), do: :north
  defp turn(:west,  :left), do: :south

  defp update_position({direction, distance}, %{x: x, y: y, heading: heading}) do
    new_heading = turn(heading, direction)
    {new_x, new_y} = move(x, y, new_heading, distance)
    %{x: new_x, y: new_y, heading: new_heading}
  end
end
