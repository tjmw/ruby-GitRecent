module GitRecent
  require 'open3'

  class ReflogLine
    def initialize(line)
      @line = line
    end

    def is_checkout?
      split_line[2] == 'checkout:'
    end

    def ends_in_sha?
      split_line.last =~ /\A([0-9a-f]{40}|[0-9a-f]{7}\Z)/
    end

    def last_field
      split_line.last
    end

    private

    def split_line
      @split_line ||= @line.split(' ')
    end
  end

  class BranchLister
    def initialize; end

    def branch_names
      @recent_branch_names ||= begin
        Open3.pipeline_r('git reflog') do |o, ts|
          recent_branches = {}

          o.each_line do |line_string|
            line = GitRecent::ReflogLine.new(line_string)

            next unless line.is_checkout?
            next if line.ends_in_sha?

            recent_branches[line.last_field] = true

            return recent_branches.keys if recent_branches.keys.length == 5
          end

          return recent_branches.keys
        end
      end
    end
  end
end
