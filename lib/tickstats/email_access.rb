require 'gmail'

module TickStats
  class EmailAccess

    def initialize config, logger = nil
      @logger = logger
      @logger.debug "EmailAccess::initialize->config:#{config.inspect}" if @logger
      @config = config
      @config[:pass] = ENV['TICK_PASS'] || nil
      raise "No ENV 'TICK_PASS' set." if @config[:pass].nil?
    end

    def fetch
      @logger.debug "EmailAccess::fetch"
      data = []
      with_email do |account|
        data = read account
      end
      data
    end

    private

    def with_email
      @logger.debug "EmailAccess::with_email->config:#{@config.inspect}"
      Gmail.new(@config[:user], @config[:pass]) do |account|
        yield account
      end
    end

    def read account
      @logger.debug "EmailAccess::read->account:#{account.inspect}"
      data = []
      account.mailbox(@config[:label]).emails.each do |email|
        @logger.debug "EmailAccess::read->email:#{email.inspect}"
        data << {subject: email.message.subject.to_s, body: email.message.body.to_s}
      end
      @logger.debug "EmailAccess::read->data:#{data.inspect}"
      data
    end

  end
end
