module GitRecent
  require 'open3'

  class BranchLister
    def branch_names
      @recent_branch_names ||= begin
        Open3.pipeline_r('git reflog') do |o, ts|
          recent_branches = {}

          o.each_line do |line_string|
            line = GitRecent::ReflogLine.new(line_string)

            checked_out_entity = line.checked_out_entity

            next unless checked_out_entity
            next if looks_like_sha? checked_out_entity

            recent_branches[checked_out_entity] = true

            return recent_branches.keys if recent_branches.keys.length == 5
          end

          return recent_branches.keys
        end
      end
    end

    private

    def looks_like_sha?(item)
      item =~ /\A([0-9a-f]{40}|[0-9a-f]{7})\Z/
    end
  end
end
