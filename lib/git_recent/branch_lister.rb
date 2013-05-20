module GitRecent
  class BranchLister
    private

    attr_accessor :reflog_iterator

    public

    def initialize(reflog_iterator=GitRecent::ReflogIterator.new)
      @reflog_iterator = reflog_iterator
    end

    def branch_names
      @recent_branch_names ||= begin
        recent_branches = {}

        reflog_iterator.each do |reflog_line|
          checked_out_entity = reflog_line.checked_out_entity

          next unless checked_out_entity
          next if looks_like_sha? checked_out_entity

          recent_branches[checked_out_entity] = true

          return recent_branches.keys if recent_branches.keys.length == 5
        end

        recent_branches.keys
      end
    end

    private

    def looks_like_sha?(item)
      item =~ /\A([0-9a-f]{40}|[0-9a-f]{7})\Z/
    end
  end
end
