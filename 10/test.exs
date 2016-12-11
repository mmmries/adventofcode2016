Code.require_file("assembler.ex")

ExUnit.start

defmodule AssemblerTest do
  use ExUnit.Case, async: true

  test "basic bot instructions" do
    instructions = """
      value 5 goes to bot 2
      bot 2 gives low to bot 1 and high to bot 0
      value 3 goes to bot 1
      bot 1 gives low to output 1 and high to bot 0
      bot 0 gives low to output 2 and high to output 0
      value 2 goes to bot 2
      """

    assembled = Assembler.run(instructions)
    assert Assembler.contents_of_bin(assembled, "0") == 5
    assert Assembler.contents_of_bin(assembled, "1") ==  2
    assert Assembler.contents_of_bin(assembled, "2") == 3
    assert Assembler.who_compared(assembled, {2,5}) == "2"
  end
end
