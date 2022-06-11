module PassengerTop
  class Formatter

    def initialize(data)
      @data = data
    end

    def simple
      @data.map do |client_id, client|
        {
          thread: client["thread_name"],
          client_id: client_id,
          pid: client["current_request"]["session"]["pid"],
          state: client["connection_state"],
          method: client["current_request"]["method"],
          host: client["current_request"]["host"],
          path: client["current_request"]["path"],
          duration: -client["connected_at"]["relative_timestamp"].round(2)
        }
      end
    end

    def slow
      simple.select { |row| row[:duration] > 5 }
    end

  end
end
