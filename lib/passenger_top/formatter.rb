module PassengerTop
  class Formatter

    def initialize(data)
      @data = data
    end

    def simple
      @data.map do |client_id, client|
        {
          thread: client.dig("thread_name"),
          client_id: client_id,
          pid: client.dig("current_request", "session", "pid"),
          state: client.dig("connection_state"),
          method: client.dig("current_request", "method"),
          host: client.dig("current_request", "host"),
          path: client.dig("current_request", "path"),
          duration: -client.dig("connected_at", "relative_timestamp")&.round(2)
        }
      end
    end

    def slow
      simple.select { |row| row[:duration] > 5 }
    end

  end
end
