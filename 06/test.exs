Code.require_file("unjammed.ex")

ExUnit.start()

defmodule UnjammedTest do
  use ExUnit.Case

  test "it can unjam a signal by looking for the most common letters" do
    input = """
      eedadn
      drvtee
      eandsr
      raavrd
      atevrs
      tsrnev
      sdttsa
      rasrtv
      nssdts
      ntnada
      svetve
      tesnvt
      vntsnd
      vrdear
      dvrsen
      enarar
      """
    assert Unjammed.by_common_position(input) == "easter"
  end
end
