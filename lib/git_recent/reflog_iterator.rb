module GitRecent
  require 'open3'

  class ReflogIterator
    def each
      Open3.pipeline_r('git reflog') do |o, ts|
        o.each_line do |line_string|
          yield GitRecent::ReflogLine.new(line_string)
        end
      end
    end
  end
end
