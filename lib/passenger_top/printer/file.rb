module PassengerTop
  module Printer
    class File

      attr_reader :io

      def initialize(io:)
        @io = io
      end

      def write(data)
        tp.set(:io, io)
        tp.set(:max_width, 100)

        formatter = PassengerTop::Formatter.new(data)

        io.write "Requests logged: #{formatter.simple.size}\n"
        io.write "Slow requests logged: #{formatter.slow.size}\n\n"

        io.write "Requests\n"
        tp(formatter.simple)

        io.write "\n\nSlow requests\n"
        tp(formatter.slow)
        io.write("\n")
      end

    end
  end
end
