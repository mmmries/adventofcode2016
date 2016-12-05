Code.require_file("buster.ex")
Code.require_file("advanced_buster.ex")

ExUnit.start

defmodule BusterTest do
  use ExUnit.Case, async: true

  @tag timeout: 120_000
  test "discover the code for door abc" do
    assert Buster.code_for("abc") == "18f47a30"
  end

  @tag timeout: 120_000
  test "discover position-based code for abc" do
    assert AdvancedBuster.code_for("abc") == "05ace8e3"
  end
end
