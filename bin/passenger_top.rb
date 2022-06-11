#!/usr/bin/env ruby
require "./lib/passenger_top"

$stop = false
Signal.trap('TERM') { $stop = true }
Signal.trap('SIGINT') { $stop = true }


iterations = 1

data = {}

until $stop do
  data.each { |client_id, client| data[client_id]["connection_state"] = "COMPLETE" }

  response = `passenger-status --show=requests`
  data.merge! PassengerTop::Parser.parse!(response)

  # output
  system("clear")
  puts "Current iteration: #{iterations}"

  puts "\nRequests\n"
  tp PassengerTop::Formatter.new(data).simple.last(5)

  puts "\nSlow requests\n"
  tp PassengerTop::Formatter.new(data).slow.last(5)

  iterations += 1
end

puts
exit(0)
