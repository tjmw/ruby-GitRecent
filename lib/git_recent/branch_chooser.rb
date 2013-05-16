module GitRecent
  class BranchChooser
    private

    attr_reader :choices, :input_stream, :output_stream

    public

    def initialize(choices, input_stream=$stdin, output_stream=$stdout)
      @choices = choices
      @input_stream = input_stream
      @output_stream = output_stream
    end

    def request_choice
      display_choices

      output_stream.print 'Please select a branch: '
      input = input_stream.gets.strip
      choice_index = input.to_i - 1

      return choices.fetch(choice_index) if valid_choice?(choice_index)
      nil
    end

    private

    def display_choices
      choices.each_with_index do |branch, i|
        output_stream.puts "[#{i+1}] #{branch}"
      end
    end

    def valid_choice?(choice_index)
      (0..choices.length-1).cover? choice_index
    end
  end
end
