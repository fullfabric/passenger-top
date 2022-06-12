#!/usr/bin/env ruby
require "./lib/passenger_top"

$stop = false
Signal.trap('TERM') { $stop = true }
Signal.trap('SIGINT') { $stop = true }

write = true
iterations = 1

data = {}

# logger = File.open("./passenger_top.#{Process.pid}.log", "wb")
logger = File.open("./passenger_top.log", "wb")
printer = PassengerTop::Printer.new(logger: logger)
tp.set(:io, printer)
tp.set(:max_width, 100)

until $stop do
  data.each { |client_id, client| data[client_id]["connection_state"] = "COMPLETE" }

  response = `passenger-status --show=requests`
  data.merge! PassengerTop::Parser.parse!(response)

  if write
    write = false

    formatter = PassengerTop::Formatter.new(data)

    printer.clear

    printer.write "Current iteration: #{iterations}\n"
    printer.write "Requests logged: #{formatter.simple.size}\n"
    printer.write "Slow requests logged: #{formatter.slow.size}\n\n"

    printer.write "Requests\n"
    tp(formatter.simple.last(10))

    printer.write "\n\nSlow requests\n"
    tp(formatter.slow.last(10))
    printer.write("\n")
  end

  iterations += 1
  write = iterations % 10 == 0

  sleep 0.1
end

puts
exit(0)
