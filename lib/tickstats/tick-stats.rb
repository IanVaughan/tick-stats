require 'gmail'
require 'app_conf'
require 'logger'
require 'yaml'
require 'sequel'

class TickStats
  EMAIL_SUBJECT = 'Tickspot Email of Shame'

  def initialize
    conf = AppConf.new
    conf.load 'settings.yml'

    @gmail = Gmail.new(conf.name, ENV["TICK_PASS"] || prompt)
    @totals = {}

    @logger = Logger.new('tick.log')

    dbconfig = YAML::load(File.open('database.yml'))
    @db = Sequel.connect(dbconfig['local_db'])
  end

  def prompt
    ""
  end

  def run
    # @gmail.inbox.emails(:all, :from => "tickspot@globaldev.co.uk").each do |email|
    # @gmail.inbox.emails.each do |email|
    # @gmail.mailbox("[Gmail]/Bin").emails.each do |email|
    # @gmail.label("Bin").emails do |email|
    # @gmail.mailbox("").emails do |emails|
    labels do |email|
      @logger.debug email
      parse email.message.body.to_s if email.subject =~ /#{EMAIL_SUBJECT}/
    end

    @gmail.logout
  end

  private

  def labels
    @gmail.labels.all.each do |l|
      begin
        count = @gmail.mailbox(l).count
        @logger.debug "#{l} : #{count}"

        @gmail.mailbox(l).emails(:from => "tickspot@globaldev.co.uk").each do |email|
          @logger.debug email.subject
          yield email
        end # if count < 240
      rescue Net::IMAP::NoResponseError => e
        @logger.error "Failed to get #{l} => #{e}"
      end
    end
  end

  def date_from message
    TICKSPOT_FOR = 'Tickspot for' # can this be converted into a regex? "eg" => /eg/

    message.each_line do |line|
      pos = line =~ /#{TICKSPOT_FOR}/
      unless pos.nil?
        pos += TICKSPOT_FOR.length + 1
        return line[pos, line.length-pos-2].chomp
      end
    end
    nil
  end

  def names_from message
    search = '  '
    message.each_line do |line|
      pos = line =~ /#{search}/
      unless pos.nil?
        names = line.lstrip.split(':')
        yield names[0], 7.5 - names[1].to_i
      end
    end
  end

  def parse message
    names = Hash.new(0)

    date = date_from message
    @logger.info date
    return if date.nil?

    names_from message do |name, hours|
      @logger.debug "#{name}, #{hours}"
      names[name] = hours
    end

    @totals[date] = names
  end

end

tp = TickStats.new
tp.run
