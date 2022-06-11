module PassengerTop
  class Formatter

    def initialize(data)
      @data = data
    end

    def simple
      output = @data.map do |client_id, client|
        {
          thread: client["thread_name"],
          client_id: client_id,
          # state: client["connection_state"],
          method: client["current_request"]["method"],
          host: client["current_request"]["host"],
          path: client["current_request"]["path"],
          duration: -client["connected_at"]["relative_timestamp"].round(2)
        }
      end
    end

  end
end
