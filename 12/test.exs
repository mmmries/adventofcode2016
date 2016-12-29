Code.require_file("vm.ex")

ExUnit.start()

defmodule VmTest do
  use ExUnit.Case, async: true

  test "executing assembly instructions" do
    instructions = """
      cpy 41 a
      inc a
      inc a
      dec a
      jnz a 2
      dec a
      """

    assert Vm.run(instructions) |> Map.get(:a) == 42
  end
end
