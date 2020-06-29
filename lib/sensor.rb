# frozen_string_literal: true

class Sensor
  def initialize(device:, name:, reference:, device_log_content:)
    @device = device
    @name = name
    @device_log_content = device_log_content
    @reference = reference
  end

  def classification
    Object.const_get(device.capitalize).new(log_content: device_log_content, reference: reference)
          .classification
  end

  attr_reader :device, :device_log_content, :reference, :name
end
