module GitRecent
  require 'open3'

  class BranchChooser
    def initialize(choices)
      @choices = choices
    end

    def request_choice
      @choices.each_with_index do |branch, i|
        puts "[#{i+1}] #{branch}"
      end

      print 'Please select a branch: '
      input = $stdin.gets.strip

      branch = @choices.fetch(input.to_i - 1)
      branch
    end
  end
end
