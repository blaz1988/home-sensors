# frozen_string_literal: true

class SensorEvaluator
  DEVICES = %w[thermometer humidity monoxide].freeze

  def initialize(log_contents_str)
    @log_contents_str = log_contents_str
  end

  def self.call(log_contents_str)
    new(log_contents_str).call
  end

  def call
    parse_log_contents
    classifications_for_devices
  end

  private

  attr_reader :log_contents_str, :log_parser

  def parse_log_contents
    @log_parser = LogParser.new(log_contents: log_contents_str)
    @log_parser.parse
  end

  def classifications_for_devices
    DEVICES.each_with_object({}) do |device, result|
      log_parser.log_contents_hash[device].each do |name, device_log_content|
        sensor = Sensor.new(device: device,
                            name: name,
                            reference: log_parser.reference[device],
                            device_log_content: device_log_content)
        result[sensor.name] = sensor.classification
      end
    end
  end
end
