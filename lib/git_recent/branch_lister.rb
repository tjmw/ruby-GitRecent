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
          checked_out_entity = reflog_line.checked_out_entity

          next unless checked_out_entity
          next unless local_branch_exists? checked_out_entity

          recent_branches[checked_out_entity] = true

          return recent_branches.keys if recent_branches.keys.length == 5
        end

        recent_branches.keys
      end
    end

    private

    def local_branch_exists?(checked_out_entity)
      local_branches.include? checked_out_entity
    end
  end
end
