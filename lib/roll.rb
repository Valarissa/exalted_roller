class Roll
  attr_accessor :action, :name

  def initialize(options={})
    roll_dice(options[:dice].to_i || 1)
    self.name = options[:name] || "Anon"
    self.action = options[:action] || "doing something"
  end

  def roll_dice(num_of_dice)
    num_of_dice = 1 if num_of_dice.to_i < 1
    num_of_dice.times do |die|
      result << roll_die
    end
  end

  def roll_die
    Random.rand(10) + 1
  end

  def display_roll
    "#{self.name} #{roll_text} for #{self.action}. Results: #{result_text}"
  end

  def result_text
    "#{dice_rolled} #{successes_text}"
  end

  def roll_text
    "rolled #{self.result.count} #{(self.result.count > 1) ? "dice" : "die"}"
  end

  def dice_rolled
    self.result.join(",")
  end

  def successes_text
    case
    when result_successes == 1
      "(#{result_successes} success)"
    when result_successes > 1
      "(#{result_successes} successes)"
    when result_successes == 0
      "(Fail)"
    else
      "(#{result_successes * -1}x botch!)"
    end
  end

  def result_successes
    return success_total if success_total > 0
    return botches
  end

  def botches
    self.result.select{|roll| roll == 1}.count * -1
  end

  def success_total
    successes + natural_tens
  end

  def successes
    self.result.select{|roll| roll >= 7 and roll < 10}.count
  end

  def natural_tens
    self.result.select{|roll| roll == 10}.count * 2
  end

  def result
    @result ||= []
  end
end
