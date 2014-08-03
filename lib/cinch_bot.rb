require 'cinch'
require "#{File.dirname(__FILE__)}/roll"
require "#{File.dirname(__FILE__)}/plugins/roller"

bot = Cinch::Bot.new do
  configure do |c|
    c.nick            = "MistralRoller"
    c.server          = "irc.universaldark.net"
    c.channels        = ["#chasethewind"]
  end

  on :message, /(\d+)?d10(?:\s*(.*))?/ do |m, num, action|
    roll = Roll.new({dice: num, action: action, name: m.user.nick})
    m.reply roll.display_roll, false
  end
end

bot.start
