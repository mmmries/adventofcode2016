Code.require_file("directory.ex")

IO.puts "---- Summing Sectors ----"
str = File.read!("input.txt")
sum = Directory.sum_real_sector_ids(str)
IO.puts"\treal sectors sum to: #{sum}"

IO.puts "---- Decrypting Names ----"
northpole_object_storage = str
                          |> String.split("\n")
                          |> Enum.map(&String.trim/1)
                          |> Enum.reject(&( &1 == "" ))
                          |> Enum.map(&Directory.parse/1)
                          |> Enum.reject(&( &1.decoy? ))
                          |> Enum.find(&( String.contains?(&1.name, "northpole") ))
IO.puts "\tnorthpol object storage is in sector: #{northpole_object_storage.sector}"
