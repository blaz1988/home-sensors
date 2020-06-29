# frozen_string_literal: true

class SensorEvaluator
  def initialize(log_contents_str)
    @log_contents_str = log_contents_str
  end

  def self.call(log_contents_str)
    new(log_contents_str).call
  end

  def call
    classifications_for_devices
  end

  private

  def devices
    [
      Thermometer.new(log: log_contents_str),
      Humidity.new(log: log_contents_str),
      Monoxide.new(log: log_contents_str)
    ]
  end

  def classifications_for_devices
    @classifications_for_devices ||= devices.map do |device|
      Sensor.new(device: device).classification
    end
  end

  attr_reader :log_contents_str
end
