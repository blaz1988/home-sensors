# frozen_string_literal: true

class Monoxide
  KEEP = 'keep'
  DISCARD = 'discard'

  def initialize(log_content:, reference:)
    @log_content = log_content
    @reference = reference
  end

  def classification
    return DISCARD if max_carbon_monoxide_from_log > 3

    KEEP
  end

  private

  def max_carbon_monoxide_from_log
    LogParser.new(log_contents: log_content).max_difference_from_log(reference, :integer)
  end

  attr_reader :log_content, :reference
end
