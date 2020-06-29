# frozen_string_literal: true

RSpec.describe SensorEvaluator do
  describe '#call' do
    subject { described_class.call(log_contents_str) }

    let(:log_contents_str) { File.read(log_path) }
    let(:expected_output) do
      {
        'temp-1' => 'precise',
        'temp-2' => 'ultra precise',
        'hum-1' => 'keep',
        'hum-2' => 'discard',
        'mon-1' => 'keep',
        'mon-2' => 'discard'
      }
    end

    context 'when log contains valid readings' do
      let(:log_path) { 'spec/fixtures/sensor_evaluator.log' }

      it { is_expected.to eq expected_output }
    end
  end
end
