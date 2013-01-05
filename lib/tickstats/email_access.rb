require 'gmail'

module TickStats
  class EmailAccess

    def initialize config
      @config = config
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
        data << email.message.body.to_s
      end
      data
    end

  end
end
