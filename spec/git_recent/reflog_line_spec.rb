require 'spec_helper'

describe GitRecent::ReflogLine do
  let(:reflog_line) { GitRecent::ReflogLine.new(reflog_string) }

  context 'when the reflog line is for a checkout' do
    let(:reflog_string) { '061ead5 HEAD@{9}: checkout: moving from master to test' }

    describe '#from_branch' do
      it 'returns the correct branch name' do
        reflog_line.from_branch.should eql('master')
      end
    end

    describe '#to_branch' do
      it 'returns the correct branch name' do
        reflog_line.to_branch.should eql('test')
      end
    end
  end

  context 'when the reflog line is not for a checkout' do
    let(:reflog_string) { 'c58e2b4 HEAD@{16}: commit: Initial commit' }

    describe '#from_branch' do
      it 'returns nil' do
        reflog_line.from_branch.should be_nil
      end
    end

    describe '#to_branch' do
      it 'returns nil' do
        reflog_line.to_branch.should be_nil
      end
    end
  end
end
