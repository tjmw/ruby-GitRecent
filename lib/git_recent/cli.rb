module GitRecent
  require 'thor'

  class Cli < Thor
    DEFAULT_MAX_BRANCHES = 5

    class_option :max, :type => :numeric

    desc 'list', 'List recently checked-out git branches'
    def list
      recent_branch_names.each do |branch_name|
        puts branch_name
      end
    end

    desc 'checkout', 'Interactively checkout a recently checked-out git branch'
    def checkout
      chooser = GitRecent::BranchChooser.new recent_branch_names

      selected_branch = chooser.request_choice

      if selected_branch
        Git.open('.').checkout(selected_branch)
      end
    end

    private
    def recent_branch_names
      branch_lister = GitRecent::BranchLister.new
      recent_branch_names = branch_lister.branch_names(options[:max] || DEFAULT_MAX_BRANCHES)
      abort 'No recent branches' if recent_branch_names.empty?
      recent_branch_names
    end
  end
end
