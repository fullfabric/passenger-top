class PassengerTop::Printer

  def initialize(logger:)
    @logger = logger
  end

  def clear
    @logger.truncate(0)
    STDOUT.write("\e[H\e[2J")
  end

  def write(string)
    @logger.write(string)
    @logger.flush

    STDOUT.write(string)
  end

  alias_method :puts, :write

  def close
    @logger.close
  end

end
