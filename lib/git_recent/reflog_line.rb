module GitRecent
  class ReflogLine
    def initialize(line)
      @line = line
    end

    def from_branch
      return unless is_checkout?
      split_line[-3]
    end

    def to_branch
      return unless is_checkout?
      split_line.last
    end

    private

    def is_checkout?
      @is_checkout ||= begin
        split_line[2] == 'checkout:'
      end
    end

    def split_line
      @split_line ||= @line.split(' ')
    end
  end
end
