Code.require_file("compress.ex")
Code.require_file("compress_v2.ex")

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

defmodule CompressV2Test do
  use ExUnit.Case, async: true

  test "ADVENT" do
    assert CompressV2.desize("ADVENT") == String.length("ADVENT")
  end

  test "(1x5)BC" do
    assert CompressV2.desize("A(1x5)BC") == String.length("ABBBBBC")
  end

  test "(3x3)XYZ" do
    assert CompressV2.desize("(3x3)XYZ") == String.length("XYZXYZXYZ")
  end

  test "X(8x2)(3x3)ABCY" do
    assert CompressV2.desize("X(8x2)(3x3)ABCY") == String.length("XABCABCABCABCABCABCY")
  end

  test "(27x12)(20x12)(13x14)(7x10)(1x12)A" do
    assert CompressV2.desize("(27x12)(20x12)(13x14)(7x10)(1x12)A") == 241_920
  end

  test "(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN" do
    assert CompressV2.desize("(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN") == 445
  end
end
