# frozen_string_literal: true

class LogParser
  REFERENCE = 'reference'
  DEVICES = %w[thermometer humidity monoxide].freeze

  attr_reader :log_contents, :log_contents_hash, :reference

  def initialize(log_contents:)
    @log_contents = log_contents
    @log_contents_hash = {}
  end

  def parse
    @device_type = nil
    @device_name = nil
    log_contents.each_line do |line|
      reference_readings(line) if line.include?(REFERENCE)

      define_device_data(line.split(' ')) if device_name?(line)
      populate_device_values(line) if timestamp?(line)
    end
  end

  def max_difference_from_log(reference, type)
    @max_difference_from_log ||=
      log_contents.each_line.map do |line|
        (reference - first_number_from_log(line, type)).abs
      end.max
  end

  private

  def numbers_from_log(line, type)
    numbers_from_log = type == :decimal ? line.scan(/(\d+[.,]\d+)/) : line.scan(/( \d+)/)
    raise 'Invalid log format!' if numbers_from_log.empty?

    numbers_from_log
  end

  def first_number_from_log(line, type)
    return numbers_from_log(line, type)[0][0].to_f if type == :decimal

    numbers_from_log(line, type)[0][0].to_i
  end

  def reference_readings(line)
    readings = line.scan(/[\d.]+/)
    raise 'Invalid reference readings!' if readings.empty?

    @reference = { DEVICES[0] => readings[0].to_f,
                   DEVICES[1] => readings[1].to_f,
                   DEVICES[2] => readings[2].to_i }
  end

  def define_device_data(line_array)
    raise 'Invalid device data!' if line_array.empty?

    @device_type = line_array[0]
    @device_name = line_array[1]
    if log_contents_hash[@device_type].nil?
      log_contents_hash[@device_type] = { @device_name => '' }
    else
      log_contents_hash[@device_type][@device_name] = ''
    end
  end

  def populate_device_values(line)
    log_contents_hash[@device_type][@device_name] = log_contents_hash[@device_type][@device_name] + line
  end

  def device_name?(line)
    DEVICES.detect { |device| line.include?(device) }
  end

  def timestamp?(line)
    line.scan(/(\d+[-T]\d+)/).any?
  end
end
