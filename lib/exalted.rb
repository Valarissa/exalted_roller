require 'roll'

class Exalted < Roll
  def initialize(options={})
    opts = {
      target: 7,
      crit_handler: :double,
    }.merge(options)
    super(opts)
  end

  def botches
    result.count{|roll| roll == 1} * -1
  end

  def critical_fail
    botches
  end

  def successes_text
    case
    when result_successes == 1
      "#{result_successes} success"
    when result_successes > 1
      "#{result_successes} successes"
    when result_successes == 0
      "Fail"
    else
      "#{result_successes * -1}x botch!"
    end
  end
end
