defmodule Cubicle do
  require Integer

  def open?({x,y}, key) do
    (x * x + 3 * x + 2 * x * y + y + y*y + key)
    |> Integer.to_string(2)
    |> String.split("")
    |> Enum.filter(&( &1 == "1" ))
    |> Enum.count
    |> Integer.is_even
  end

  def shortest_distance_between(start, target, min, max, key) do
    shortest_distance_between(start, target, min, max, key, [])
  end

  defp shortest_distance_between(x, x, _min, _max, _key, path), do: Enum.count(path)
  defp shortest_distance_between({cx, _cy}, _target, {minx,_miny}, _max, _key, _path) when cx < minx, do: nil
  defp shortest_distance_between({_cx, cy}, _target, {_minx,miny}, _max, _key, _path) when cy < miny, do: nil
  defp shortest_distance_between({cx, _cy}, _target, _min, {maxx,_maxy}, _key, _path) when cx > maxx, do: nil
  defp shortest_distance_between({_cx, cy}, _target, _min, {_maxx,maxy}, _key, _path) when cy > maxy, do: nil
  defp shortest_distance_between({cx,cy}, target, min, max, key, path) do
    new_path = [{cx,cy} | path]
    distances = [{cx-1,cy},{cx+1,cy},{cx,cy-1},{cx,cy+1}]
                |> Enum.reject(&( Enum.member?(path, &1) ))
                |> Enum.filter(&( open?(&1, key) ))
                |> Enum.map(&( shortest_distance_between(&1, target, min, max, key, new_path) ))
                |> Enum.reject(&( &1 == nil ))
    case distances do
      [] -> nil
      list -> Enum.min(list)
    end
  end

  def count_unique_locations(start, min, max_distance, key) do
    count_unique_locations(start, min, max_distance, key, []) |> Enum.count
  end

  defp count_unique_locations(_curr, _min, limit, _key, path) when length(path) > limit, do: path
  defp count_unique_locations({cx,cy}, min, limit, key, path) do
    new_path = [{cx,cy} | path]
    paths = [{cx-1,cy}, {cx+1,cy}, {cx,cy-1}, {cx,cy+1}]
            |> Enum.reject(&( Enum.member?(path, &1) ))
            |> Enum.filter(&( larger_than_min?(&1, min) ))
            |> Enum.filter(&( open?(&1, key) ))
            |> Enum.map(&( count_unique_locations(&1, min, limit, key, new_path) ))
    [{cx,cy} | paths] |> List.flatten |> Enum.uniq
  end

  defp larger_than_min?({cx,_cy}, {minx, _miny}) when cx < minx, do: false
  defp larger_than_min?({_cx,cy}, {_minx, miny}) when cy < miny, do: false
  defp larger_than_min?(_current, _min), do: true
end
