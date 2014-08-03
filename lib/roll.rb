class Roll

  def self.roll(dice, opts={})
    new(opts.merge(dice: dice)).display_roll
  end

  attr_accessor :action, :name, :crit_handler, :crit_target, :target, :dice

  def initialize(options={})
    self.target = options[:target] || 7
    self.crit_target = options[:crit_target] || 10
    self.crit_handler = options[:crit_handler] || :double
    self.name = options[:name] || "Anon"
    self.action = options[:action] || "doing something"
    self.dice = options[:dice].to_i || 1
    roll_dice(dice)
  end

  def roll_dice(num_of_dice)
    num_of_dice = 1 if num_of_dice.to_i < 1
    temp_result = []
    num_of_dice.times do |die|
      temp_result << roll_die
    end
    resolve_crits(temp_result)
    result.concat(temp_result)
  end

  def display_roll
    "#{name} #{roll_text} for #{action}. Results: #{result_text}"
  end

  def result
    @result ||= []
  end

  private

  def roll_die
    Random.rand(10) + 1
  end

  def result_text
    "[#{dice_rolled}] #{successes_text}"
  end

  def roll_text
    "rolled #{dice} #{(dice > 1) ? "dice" : "die"}"
  end

  def dice_rolled
    result.join(",")
  end

  def successes_text
    raise "subclass responsibility"
  end

  def critical_fail
    raise "subclass responsibility"
  end

  def result_successes
    return success_total if success_total > 0
    return critical_fail
  end

  def success_total
    crits + successes
  end

  def successes
    result.count{|roll| roll >= target and roll < crit_target}
  end

  def crits
    send("#{crit_handler}_crits", crits_rolled)
  end

  def double_crits(crits)
    crits * 2
  end

  def roll_crits(crits)
    crits
  end

  def resolve_crits(rolled)
    return if crit_handler != :roll
    return if crits_rolled(rolled) == 0
    roll_dice(crits_rolled(rolled))
  end

  def crits_rolled(rolled = result)
    rolled.count{|roll| roll >= crit_target}
  end
end
