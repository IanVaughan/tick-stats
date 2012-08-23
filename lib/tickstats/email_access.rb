require 'gmail'

module TickStats
  class EmailAccess

    def initialize config
      @config = config[:user]
    end

    def fetch
      data = []
      Gmail.new(@config[:user], @config[:pass]) do |gmail|
        gmail.mailbox(@config[:label]).emails.each do |email|
          data << email.message.body.to_s
        end
      end
      data
    end

  end
end
