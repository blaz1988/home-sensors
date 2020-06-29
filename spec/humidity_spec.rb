# frozen_string_literal: true

RSpec.describe Humidity do
  describe '#classification' do
    subject { described_class.new(log_content: log_content, reference: reference).classification }

    let(:reference) { 45.0 }
    let(:log_content) { File.read(log_path) }

    context 'when readings is within 1 humidity percent of the reference value' do
      let(:log_path) { 'spec/fixtures/keep_humidity.log' }

      it { is_expected.to eq 'keep' }
    end

    context 'when readings is outside 1 humidity percent of the reference value' do
      let(:log_path) { 'spec/fixtures/discard_humidity.log' }

      it { is_expected.to eq 'discard' }
    end

    context 'when log content is not valid' do
      let(:log_path) { 'spec/fixtures/invalid_humidity.log' }

      it 'raises error' do
        expect { subject }.to raise_error(RuntimeError, 'Invalid log format!')
      end
    end
  end
end
