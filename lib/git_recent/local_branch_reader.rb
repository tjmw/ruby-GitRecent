module GitRecent
  class LocalBranchReader
    def self.local_branches
      g = Git.open('.')
      g.branches.local.map(&:name).to_set
    end
  end
end
