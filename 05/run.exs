Code.require_file("buster.ex")
Code.require_file("advanced_buster.ex")

IO.puts "---- Cracking code for ojvtpuvg ----"
IO.puts "\tcode: #{Buster.code_for("ojvtpuvg")}"

IO.puts "---- Cracking position-based-code for ojvtpuvg ----"
IO.puts "\tcode: #{AdvancedBuster.code_for("ojvtpuvg")}"
