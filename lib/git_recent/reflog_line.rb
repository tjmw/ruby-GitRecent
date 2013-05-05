module GitRecent
  class ReflogLine
    def initialize(line)
      @line = line
    end

    def checked_out_entity
      return unless is_checkout?
      split_line.last
    end

    private

    def is_checkout?
      split_line[2] == 'checkout:'
    end

    def split_line
      @split_line ||= @line.split(' ')
    end
  end
end
