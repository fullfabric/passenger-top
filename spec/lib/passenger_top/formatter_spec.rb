describe PassengerTop::Formatter do

  it "formats output" do
    json = File.read("./spec/support/output_1")
    hash = PassengerTop::Parser.parse!(json)

    formatter = PassengerTop::Formatter.new(hash)
    output = formatter.simple

    expect(output).to be_a(Array)
    expect(output.size).to eq 2
    expect(output[0].keys).to eq([:thread, :client_id, :method, :host, :path, :duration])
  end

end
