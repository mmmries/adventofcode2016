defmodule Screen do
  def init(width, height) do
    row = List.duplicate(0, width)
    List.duplicate(row, height)
  end

  def apply(screen, {:rect, width, height}) do
    Enum.reduce(0..(height-1), screen, fn(y, rows) ->
      List.update_at(rows , y, fn(row) ->
        List.duplicate(1, width) ++ Enum.slice(row, width..-1)
      end)
    end)
  end
  def apply(screen, {:rotate_column, col, factor}) do
    screen
    |> transpose
    |> Screen.apply({:rotate_row, col, factor})
    |> transpose
  end
  def apply(screen, {:rotate_row, row, factor}) do
    shifted = Enum.reduce(1..factor, Enum.at(screen,row), fn(_, r) ->
      last = List.last(r)
      rest = Enum.slice(r, 0..-2)
      [last | rest]
    end)
    List.replace_at(screen, row, shifted)
  end

  def count_active_pixels(screen) do
    Enum.reduce(screen, 0, fn(row, sum) ->
      row_sum = Enum.reduce(row, 0, fn(element, total) -> total + element end)
      sum + row_sum
    end)
  end

  def print(screen) do
    IO.puts "   ----------    "
    screen
    |> Enum.each(fn(row) ->
      Enum.each(row, fn
        (1) -> IO.write("#")
        (0) -> IO.write(" ")
      end)
      IO.write("\n")
    end)
  end

  defp transpose([[]|_]), do: []
  defp transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end
end

defmodule Instruction do
  def parse(str) do
    str
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&parse_instruction/1)
  end

  defp parse_instruction("rect "<>dimenstions) do
    [width, height] = dimenstions |> String.split("x") |> Enum.map(&String.to_integer/1)
    {:rect, width, height}
  end
  defp parse_instruction("rotate column x="<>col_by_factor) do
    [col, factor] = col_by_factor |> String.split(" by ") |> Enum.map(&String.to_integer/1)
    {:rotate_column, col, factor}
  end
  defp parse_instruction("rotate row y="<>col_by_factor) do
    [col, factor] = col_by_factor |> String.split(" by ") |> Enum.map(&String.to_integer/1)
    {:rotate_row, col, factor}
  end
end

case System.argv do
  [width, height, filepath] ->
    width = String.to_integer(width)
    height = String.to_integer(height)
    screen = Screen.init(width, height)

    pixel_count = filepath
                  |> File.read!
                  |> Instruction.parse
                  |> Enum.reduce(screen, fn(instruction, screen) ->
                    new_screen = Screen.apply(screen, instruction)
                    Screen.print(new_screen)
                    new_screen
                  end)
                  |> Screen.count_active_pixels
    IO.puts "the screen has #{pixel_count} active pixels"
  _ ->
    IO.puts "invalid arguments"
    IO.puts "usage: elixir run.exs WIDTH HEIGHT FILENAME"
end
