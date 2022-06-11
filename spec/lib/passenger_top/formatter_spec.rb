describe PassengerTop::Formatter do

  let!(:contents) { File.read("./spec/support/output_1") }
  let!(:data) { PassengerTop::Parser.parse!(json) }

  let!(:formatter) { PassengerTop::Formatter.new(data) }

  it "formats output" do
    output = formatter.simple

    expect(output).to be_a(Array)
    expect(output.size).to eq 2

    expected_keys = [:thread, :client_id, :pid, :state, :method, :host, :path, :duration]
    expect(output[0].keys).to eq(expected_keys)
  end

  it "returns slow requests" do
    output = formatter.slow
    expect(output.size).to eq 1
  end

end
