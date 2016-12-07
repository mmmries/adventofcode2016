Code.require_file("ip.ex")

ExUnit.start

defmodule IpTest do
  use ExUnit.Case

  test "recognizing which IPs support TLS" do
    assert Ip.tls?("abba[mnop]qrst") == true
    assert Ip.tls?("abcd[bddb]xyyx") == false
    assert Ip.tls?("abcd[iobddbmnf]xyyx") == false
    assert Ip.tls?("aaaa[qwer]tyui") == false
    assert Ip.tls?("ioxxoj[asdfgh]zxcvbn") == true
  end
end
