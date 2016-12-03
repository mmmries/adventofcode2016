Code.require_file("keypad.ex")

ExUnit.start()

defmodule KeypadTest do
  use ExUnit.Case, async: true

  test "next key" do
    assert Keypad.next_key("5", ["U","L","L"]) == "1"
  end

  test "simple code" do
    input = """
      ULL
      RRDDD
      LURDL
      UUUUD
      """
    assert Keypad.code(input) == "1985"
  end
end
