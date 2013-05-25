require 'spec_helper'

describe GitRecent::BranchLister do
  let(:lister) {
    GitRecent::BranchLister.new(dummy_reflog_iterator, local_branches)
  }

  let(:dummy_reflog_iterator) {
    reflog_lines.collect { |line| GitRecent::ReflogLine.new(line) }
  }

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

  let(:local_branches) {
    Set.new(%w(master my_feature test my_other_feature))
  }

  it 'returns the correctly ordered list of branches' do
    lister.branch_names.should eql(%w(master my_feature test))
  end

  context 'when a branch is renamed' do
    let(:local_branches) {
      Set.new(%w(master my_feature test my_other_feature new_branch_name))
    }

    let(:reflog_lines) {
      [
        '43eaa15 HEAD@{0}: checkout: moving from new_branch_name to master',
        '43eaa15 HEAD@{1}: checkout: moving from master to initial_branch_name',
        'c2105f6 HEAD@{2}: checkout: moving from test to master',
        '7f3d9cc HEAD@{3}: checkout: moving from master to test'
      ]
    }

    it 'returns the correctly ordered list of branches' do
      lister.branch_names.should eql(%w(master new_branch_name test))
    end
  end
end
