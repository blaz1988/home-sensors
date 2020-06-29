# frozen_string_literal: true

RSpec.describe Thermometer do
  describe '#classification' do
    subject { described_class.new(log_content: log_content, reference: reference).classification }

    let(:reference) { 70 }
    let(:log_content) { File.read(log_path) }

    context 'when readings is within 0.5 degrees and deviation is less than 3' do
      let(:log_path) { 'spec/fixtures/ultra_precise_thermometar.log' }

      it { is_expected.to eq 'ultra precise' }
    end

    context 'when readings is within 0.5 degrees and standard deviation is under 5' do
      let(:log_path) { 'spec/fixtures/very_precise_thermometar.log' }

      it { is_expected.to eq 'very precise' }
    end

    context 'when readings is outside 0.5 degrees and standard deviation is more than 5' do
      let(:log_path) { 'spec/fixtures/precise_thermometar.log' }

      it { is_expected.to eq 'precise' }
    end

    context 'when log content is not valid' do
      let(:log_path) { 'spec/fixtures/invalid_thermometar.log' }

      it 'raises error' do
        expect { subject }.to raise_error(RuntimeError, 'Invalid log format!')
      end
    end
  end
end
