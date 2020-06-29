# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength, Layout/LineLength
RSpec.describe LogParser do
  describe '#parse' do
    subject { described_class.new(log_contents: log_contents) }

    before { subject.parse }

    let(:room_degrees) { 70 }
    let(:log_contents) { File.read(log_path) }

    let(:expected_output_for_log_contents_hash) do
      { 'thermometer' =>
        { 'temp-1' =>
          "2007-04-05T22:00 72.4\n2007-04-05T22:01 76.0\n2007-04-05T22:02 79.1\n2007-04-05T22:03 75.6\n2007-04-05T22:04 71.2\n2007-04-05T22:05 71.4\n2007-04-05T22:06 69.2\n2007-04-05T22:07 65.2\n2007-04-05T22:08 62.8\n2007-04-05T22:09 61.4\n2007-04-05T22:10 64.0\n2007-04-05T22:11 67.5\n2007-04-05T22:12 69.4\n",
          'temp-2' =>
          "2007-04-05T22:01 69.5\n2007-04-05T22:02 70.1\n2007-04-05T22:03 71.3\n2007-04-05T22:04 71.5\n2007-04-05T22:05 69.8\n" },
        'humidity' =>
        { 'hum-1' => "2007-04-05T22:04 45.2\n2007-04-05T22:05 45.3\n2007-04-05T22:06 45.1\n",
          'hum-2' =>
          "2007-04-05T22:04 44.4\n2007-04-05T22:05 43.9\n2007-04-05T22:06 44.9\n2007-04-05T22:07 43.8\n2007-04-05T22:08 42.1\n" },
        'monoxide' =>
        { 'mon-1' => "2007-04-05T22:04 5\n2007-04-05T22:05 7\n2007-04-05T22:06 9\n",
          'mon-2' =>
          "2007-04-05T22:04 2\n2007-04-05T22:05 4\n2007-04-05T22:06 10\n2007-04-05T22:07 8\n2007-04-05T22:08 6" } }
    end

    let(:expected_output_for_references) do
      { 'thermometer' => 70.0, 'humidity' => 45.0, 'monoxide' => 6 }
    end
    let(:log_path) { 'spec/fixtures/sensor_evaluator.log' }

    it 'generates correct hash values' do
      expect(subject.log_contents_hash).to eq expected_output_for_log_contents_hash
    end

    it 'generates correct values for references' do
      expect(subject.reference).to eq expected_output_for_references
    end
  end
end
# rubocop:enable Metrics/BlockLength, Layout/LineLength
