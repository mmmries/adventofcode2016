Code.require_file("directory.ex")

ExUnit.start()

defmodule DirectoryTest do
  use ExUnit.Case, async: true

  test "it recognizes a real room" do
    assert Directory.parse("aaaaa-bbb-z-y-x-123[abxyz]").decoy? == false
  end

  test "it recognizes a decoy room" do
    assert Directory.parse("totally-real-room-200[decoy]").decoy? == true
  end

  test "it can sum the sector IDs of real rooms" do
    str = """
      aaaaa-bbb-z-y-x-123[abxyz]
      a-b-c-d-e-f-g-h-987[abcde]
      not-a-real-room-404[oarel]
      totally-real-room-200[decoy]
      """

    assert Directory.sum_real_sector_ids(str) == 1514
  end

  test "it can decrypt names" do
    assert Directory.decrypt("qzmt-zixmtkozy-ivhz", 343) == "very encrypted name"
  end
end
