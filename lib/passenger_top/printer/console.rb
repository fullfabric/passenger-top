module PassengerTop
  module Printer
    class Console

      attr_reader :io

      def initialize(io:)
        @io = io
      end

      def write(data)
        formatter = PassengerTop::Formatter.new(data)

        tp.set(:io, io)
        tp.set(:max_width, 100)


        io.write("\e[H\e[2J")

        # io.write "Current iteration: #{iterations}\n"
        io.write "Requests logged: #{formatter.simple.size}\n"
        io.write "Slow requests logged: #{formatter.slow.size}\n\n"

        io.write "Requests\n"
        tp(formatter.simple.last(10))

        io.write "\n\nSlow requests\n"
        tp(formatter.slow.last(10))
        io.write("\n")
      end

    end
  end
end
