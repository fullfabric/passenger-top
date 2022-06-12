#!/usr/bin/env ruby
require "./lib/passenger_top"

$stop = false
Signal.trap('TERM') { $stop = true }
Signal.trap('SIGINT') { $stop = true }

write = true
iterations = 1

data = {}

console = PassengerTop::Printer::Console.new(io: STDOUT)

until $stop do
  data.each { |client_id, client| data[client_id]["connection_state"] = "COMPLETE" }

  stdout, stderr, status = Open3.capture3("passenger-status --show=requests")
  data.merge! PassengerTop::Parser.parse!(stdout)

  if write
    write = false
    console.write(data)
  end

  iterations += 1
  write = iterations % 10 == 0

  sleep 0.1
end

at_exit do

  # logger = File.open("./passenger_top.#{Process.pid}.log", "wb")
  file = File.open("./passenger_top.log", "wb")

  file = PassengerTop::Printer::File.new(io: file)
  file.write(data)
end
