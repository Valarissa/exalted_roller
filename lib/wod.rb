require 'roll'

class WoD < Roll
  def initialize(options={})
    opts = {
      target: 8,
      crit_handler: :roll,
    }.merge(options)
    super(opts)
  end

  private

  def roll_text
    if chance_roll?
      "took a shot in the dark"
    else
      "rolled #{dice} #{(dice > 1) ? "dice" : "die"}"
    end
  end

  def critical_fail
    if chance_roll?
      return -1 if result.count == 1 && result[0] == 1
    end

    return 0
  end

  def successes_text
    case
    when result_successes < 0
      "Dramatic Failure"
    when result_successes == 0
      "Failure"
    when result_successes < 5
      "Success (#{result_successes})"
    else
      "Dramatic Success (#{result_successes})"
    end
  end

  def chance_roll?
    dice <= 0
  end
end
