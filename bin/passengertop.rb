#!/usr/bin/env ruby
require "./lib/passenger_top"

$stop = false
Signal.trap('TERM') { $stop = true }
Signal.trap('SIGINT') { $stop = true }

REFRESH = 1
iterations = 1

data = {}

until $stop do
  response = `passenger-status --show=requests`
  data.merge! PassengerTop::Parser.parse!(response)

  output = PassengerTop::Formatter.new(data).simple
  # output
  system("clear")
  puts "Current iteration: #{iterations}"
  puts
  tp output

  iterations += 1
  sleep REFRESH
end

puts
exit(0)
