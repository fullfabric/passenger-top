module PassengerTop
  class Parser

    def self.parse!(output)
      data = JSON.parse(output.split("\n")[4..-1].join) # remove first 4 lines then parse

      data.delete("threads")

      data.inject({}) do |outer, (thread_name, data)|
        client_hash = data["active_clients"].inject({}) do |inner, (client_id, client)|
          client["thread_name"] = thread_name
          inner.merge({ client_id => client })
        end

        outer.merge(client_hash)
      end
    rescue => e
      {}
    end

  end
end
