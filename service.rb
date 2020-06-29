# frozen_string_literal: true

require './lib/sensor_evaluator'
require './lib/log_parser'
require './lib/thermometer'
require './lib/monoxide'
require './lib/humidity'
require './lib/sensor'
require 'pp'

log_contents_str = File.read('sensor.log')
pp SensorEvaluator.call(log_contents_str)
