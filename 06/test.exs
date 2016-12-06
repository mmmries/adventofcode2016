Code.require_file("unjammed.ex")

ExUnit.start()

defmodule UnjammedTest do
  use ExUnit.Case

  @input """
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

  test "it can unjam a signal by looking for the most common letters" do
    assert Unjammed.by_common_position(@input) == "easter"
  end

  test "it can unjam a signal by looking for the least common letters" do
    assert Unjammed.by_least_common(@input) == "advent"
  end
end
