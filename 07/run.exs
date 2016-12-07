Code.require_file("ip.ex")

IO.puts "---- scanning IPs for TLS support ----"
count = "input.txt"
        |> File.read!
        |> String.split("\n")
        |> Enum.map(&String.trim/1)
        |> Enum.reject(&( &1 == "" ))
        |> Enum.filter(&Ip.tls?/1)
        |> Enum.count
IO.puts "\tfound #{count} tls enabled IPs"
