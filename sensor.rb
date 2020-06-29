# frozen_string_literal: true

class Sensor
  def initialize(device:)
    @device = device
  end

  def classification
    device.get_classification
  end

  attr_reader :device
end
