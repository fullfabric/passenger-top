module PassengerTop
  class Formatter

    SLOW_REQUEST_THRESHOLD = 1

    def initialize(data)
      @data = data
    end

    def simple
      @simple ||= @data.map do |client_id, client|
        start = Time.at(client.dig("connected_at", "timestamp"))
        start_formatted = start.strftime("%b %e %H:%M:%S")

        {
          thread: client.dig("thread_name"),
          client_id: client_id,
          pid: client.dig("current_request", "session", "pid"),
          start: start_formatted,
          state: client.dig("connection_state"),
          method: client.dig("current_request", "method"),
          host: client.dig("current_request", "host"),
          path: client.dig("current_request", "path"),
          duration: -client.dig("connected_at", "relative_timestamp")&.round(2)
        }
      end
    end

    def slow
      @slow ||= simple.select { |row| row[:duration] >= SLOW_REQUEST_THRESHOLD }
    end

  end
end
