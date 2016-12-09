Code.require_file("compress.ex")

ExUnit.start

defmodule CompressTest do
  use ExUnit.Case, async: true

  test "ADVENT" do
    assert Compress.de("ADVENT") == "ADVENT"
  end

  test "(1x5)BC" do
    assert Compress.de("A(1x5)BC") == "ABBBBBC"
  end

  test "(3x3)XYZ" do
    assert Compress.de("(3x3)XYZ") == "XYZXYZXYZ"
  end

  test "A(2x2)BCD(2x2)EFG" do
    assert Compress.de("A(2x2)BCD(2x2)EFG") == "ABCBCDEFEFG"
  end

  test "(6x1)(1x3)A" do
    assert Compress.de("(6x1)(1x3)A") == "(1x3)A"
  end

  test "X(8x2)(3x3)ABCY" do
    assert Compress.de("X(8x2)(3x3)ABCY") == "X(3x3)ABC(3x3)ABCY"
  end
end
