Code.require_file("buster.ex")

ExUnit.start

defmodule BusterTest do
  use ExUnit.Case, async: true

  test "discover the code for door abc" do
    assert Buster.code_for("abc") == "18f47a30"
  end
end
