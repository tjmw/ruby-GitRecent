require 'spec_helper'

describe GitRecent::BranchChooser do
  let(:input_stream) { StringIO.new('2') }
  let(:output_stream) { StringIO.new }

  let(:chooser) {
    GitRecent::BranchChooser.new(
      %w(master my_feature production),
      input_stream,
      output_stream
    )
  }

  describe '#request_choice' do
    it 'presents the correct options' do
      chooser.request_choice

      output_stream.string.should include('[1] master')
      output_stream.string.should include('[2] my_feature')
      output_stream.string.should include('[3] production')
    end

    context 'when a valid branch is chosen' do
      let(:input_stream) { StringIO.new('2') }

      it 'returns the chosen branch name' do
        chooser.request_choice.should eql('my_feature')
      end
    end

    context 'when an invalid branch is chosen' do
      let(:input_stream) { StringIO.new('foo') }

      it 'returns nil' do
        chooser.request_choice.should be_nil
      end
    end
  end
end
