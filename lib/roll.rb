class Roll
  attr_accessor :action, :name, :handler, :threshold, :dice

  def initialize(options={})
    self.threshold = options[:threshold] || 8
    self.handler = options[:tens] || :double
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
    resolve_tens(temp_result)
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
    "#{successes_text} #{dice_rolled}"
  end

  def roll_text
    "rolled #{dice} #{(dice > 1) ? "dice" : "die"}"
  end

  def dice_rolled
    "[#{result.join(",")}]"
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

  def result_successes
    return success_total if success_total > 0
    return botches
  end

  def botches
    result.count{|roll| roll == 1} * -1
  end

  def success_total
    natural_tens + successes
  end

  def successes
    result.count{|roll| roll >= threshold and roll < 10}
  end

  def natural_tens
    send("#{handler}_tens", tens_rolled)
  end

  def double_tens(tens)
    tens * 2
  end

  def roll_tens(tens)
    tens
  end

  def resolve_tens(rolled)
    return if handler != :roll
    return if tens_rolled(rolled) == 0
    roll_dice(tens_rolled(rolled))
  end

  def tens_rolled(rolled = result)
    rolled.count{|roll| roll == 10}
  end
end
