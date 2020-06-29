# frozen_string_literal: true

class Thermometer
  ULTRA_PRECISE = 'ultra precise'
  VERY_PRECISE = 'very precise'
  PRECISE = 'precise'

  def initialize(log_content:, reference:)
    @log_content = log_content
    @reference = reference
  end

  def classification
    case max_degrees_difference_from_log
    when range_for_ultra_precise
      ULTRA_PRECISE
    when range_for_very_precise
      VERY_PRECISE
    else
      PRECISE
    end
  end

  private

  def max_degrees_difference_from_log
    LogParser.new(log_contents: log_content).max_difference_from_log(reference, :decimal)
  end

  def range_for_ultra_precise
    0..(0.5 * 3)
  end

  def range_for_very_precise
    0..(0.5 * 5)
  end

  attr_reader :log_content, :reference
end
