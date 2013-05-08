require 'gmail'

module TickStats
  class EmailAccess

    def initialize logger = nil
      @logger = logger(STDOUT)
      @config = {}
      @config[:user] = ENV['TICK_USER'] || nil
      @config[:pass] = ENV['TICK_PASS'] || nil
      @config[:label] = ENV['TICK_LABEL'] || nil
      # %w{:user :pass :label}.each
      raise "No ENV 'TICK_PASS' set." if @config[:pass].nil?
    end

    def fetch
      data = []
      with_email do |account|
        data = read account
      end
      data
    end

    private

    def with_email
      Gmail.new(@config[:user], @config[:pass]) do |account|
        yield account
      end
    end

    def read account
      data = []
      account.mailbox(@config[:label]).emails.each do |email|
        data << {subject: email.message.subject.to_s, body: email.message.body.to_s}
      end
      data
    end

  end
end
