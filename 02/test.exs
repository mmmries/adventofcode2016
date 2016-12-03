Code.require_file("keypad.ex")
Code.require_file("weird_keypad.ex")

ExUnit.start()

defmodule KeypadTest do
  use ExUnit.Case, async: true

  @input """
    ULL
    RRDDD
    LURDL
    UUUUD
    """

  test "next key" do
    assert Keypad.next_key("5", ["U","L","L"]) == "1"
  end

  test "simple code" do
    assert Keypad.code(@input) == "1985"
  end

  test "weird keypad code" do
    assert WeirdKeypad.code(@input) == "5DB3"
  end
end
