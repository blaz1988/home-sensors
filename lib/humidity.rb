# frozen_string_literal: true

class Humidity
  KEEP = 'keep'
  DISCARD = 'discard'

  def initialize(log_content:, reference:)
    @log_content = log_content
    @reference = reference
  end

  def classification
    return DISCARD if max_percent_difference_from_log > 1

    KEEP
  end

  private

  def max_percent_difference_from_log
    LogParser.new(log_contents: log_content).max_difference_from_log(reference, :decimal)
  end

  attr_reader :log_content, :reference
end
