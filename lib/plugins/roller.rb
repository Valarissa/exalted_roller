require 'cinch'

class Roller
  include Cinch::Plugin

  match(/roll (\d+)?d10(?:\s*(.*))?/)

  def execute(m, num, action)
    roll = Roll.new({dice: num, action: action, name: m.user.nick})
    m.reply roll.display_roll
  end
end
