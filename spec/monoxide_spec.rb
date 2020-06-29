# frozen_string_literal: true

RSpec.describe Monoxide do
  describe '#classification' do
    subject { described_class.new(log_content: log_content, reference: reference).classification }

    let(:reference) { 6 }
    let(:log_content) { File.read(log_path) }

    context 'when readings is within within 3 ppm of the reference value' do
      let(:log_path) { 'spec/fixtures/keep_carbon_monoxide.log' }

      it { is_expected.to eq 'keep' }
    end

    context 'when readings is outside 3 ppm of the reference value' do
      let(:log_path) { 'spec/fixtures/discard_carbon_monoxide.log' }

      it { is_expected.to eq 'discard' }
    end

    context 'when log content is not valid' do
      let(:log_path) { 'spec/fixtures/invalid_carbon_monoxide.log' }

      it 'raises error' do
        expect { subject }.to raise_error(RuntimeError, 'Invalid log format!')
      end
    end
  end
end
