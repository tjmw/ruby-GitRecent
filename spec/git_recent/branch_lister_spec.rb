require 'spec_helper'

describe GitRecent::BranchLister do
  let(:reflog_lines) {
    [
      '1e3b9a9 HEAD@{0}: checkout: moving from master to master',
      '1e3b9a9 HEAD@{1}: commit: Remove unnecessary constructor',
      '54b74f2 HEAD@{2}: checkout: moving from master to master',
      '54b74f2 HEAD@{3}: commit: Add code climate to README',
      '57372d4 HEAD@{4}: commit: Use git gem to checkout branches',
      'a7eb16d HEAD@{5}: checkout: moving from my_feature to master',
      'a7eb16d HEAD@{6}: checkout: moving from master to my_feature',
      'a7eb16d HEAD@{7}: checkout: moving from my_feature to master',
      'a7eb16d HEAD@{8}: checkout: moving from test to my_feature',
      'a7eb16d HEAD@{9}: checkout: moving from master to test'
    ]
  }

  let(:dummy_reflog_iterator) {
    reflog_lines.collect { |line| GitRecent::ReflogLine.new(line) }
  }

  let(:lister) { GitRecent::BranchLister.new(dummy_reflog_iterator) }

  it 'returns a correctly ordered list of recently checked out branches' do
    lister.branch_names.should eql(%w(master my_feature test))
  end
end
