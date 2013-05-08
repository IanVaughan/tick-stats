#require ::File.expand_path('../config/environment',  __FILE__)
#run WhiteLabelDating::MemberService::Application
#require './lib/tickstats/server'

require './lib/tick_stats'
run TickStats::Server
