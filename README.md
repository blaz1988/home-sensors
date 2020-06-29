# home_sensors

home_sensors is service written in pure Ruby. It process the log content and provide quality control evaluation.

# Usage
* SensorEvaluator.new(log_contents_str).call
* shortcut: SensorEvaluator.new(log_contents_str).call
* bundle exec ruby service.rb
    
# Tests
* bundle install
* Run all tests
    
      bundle exec rspec spec
    
* Run specific test

      bundle exec rspec spec/sensor_evaluator_spec.rb
      bundle exec rspec spec/thermometer_spec.rb
    
# Dependencies
None, other than Ruby and gem rspec. I've used it with Ruby 2.6.5 and rspec 3.9.0.

# Contributing
* Fork it
* Create your feature branch (git checkout -b my-new-feature)
* Commit your changes (git commit -am 'Add some feature')
* Push to the branch (git push origin my-new-feature)
* Create new Pull Request
