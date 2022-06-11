describe PassengerTop::Parser do

  it "parses passenger-status --show=requests output" do
    json = File.read("./spec/support/output_1")
    hash = PassengerTop::Parser.parse!(json)


    ["1-105889", "1-105890"].each do |client_id|
      expected_keys = %w(connected_at connection_state current_request lingering_request_count name number output_channel_state refcount requests_begun thread_name)
      expect(hash[client_id].keys).to eq(expected_keys)
    end

  end

end
