require 'spec_helper'

describe GitRecent::ReflogLine do
  describe '#checked_out_entity' do
    let(:reflog_line) { GitRecent::ReflogLine.new(reflog_string) }

    context 'when the reflog line is for a checkout' do
      let(:reflog_string) { '061ead5 HEAD@{9}: checkout: moving from master to test' }

      it 'returns the checked out entity name' do
        reflog_line.checked_out_entity.should eql('test')
      end
    end

    context 'when the reflog line is not for a checkout' do
      let(:reflog_string) { 'c58e2b4 HEAD@{16}: commit: Initial commit' }

      it 'returns nil' do
        reflog_line.checked_out_entity.should be_nil
      end
    end
  end
end
