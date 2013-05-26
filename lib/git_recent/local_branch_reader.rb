module GitRecent
  class LocalBranchReader
    class << self
      def local_branches_excluding_current
        local_branches.reject { |b| b.current }.map(&:name).to_set
      end

      private

      def local_branches
        g = Git.open('.')
        g.branches.local
      end
    end
  end
end
