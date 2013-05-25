module GitRecent
  class BranchLister
    private

    attr_accessor :local_branches, :reflog_iterator

    public

    def initialize(reflog_iterator=GitRecent::ReflogIterator.new,
                   local_branches=GitRecent::LocalBranchReader.local_branches)
      @reflog_iterator = reflog_iterator
      @local_branches = local_branches
    end

    def branch_names
      @recent_branch_names ||= begin
        recent_branches = {}

        reflog_iterator.each do |reflog_line|
          to_branch = reflog_line.to_branch
          recent_branches[to_branch] = true if should_include_branch? to_branch

          from_branch = reflog_line.from_branch
          recent_branches[from_branch] = true if should_include_branch? from_branch

          return recent_branches.keys if recent_branches.keys.length == 5
        end

        recent_branches.keys
      end
    end

    private

    def local_branch_exists?(checked_out_entity)
      local_branches.include? checked_out_entity
    end

    def should_include_branch?(branch)
      branch and local_branch_exists? branch
    end
  end
end
