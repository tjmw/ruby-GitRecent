module GitRecent
  require 'thor'

  class Cli < Thor
    desc 'list', 'List recently checked-out git branches'
    def list
      recent_branch_names = GitRecent::BranchLister.new.branch_names

      abort 'No recent branches' if recent_branch_names.empty?

      recent_branch_names.each do |branch_name|
        puts branch_name
      end
    end

    desc 'checkout', 'Interactively checkout a recently checked-out git branch'
    def checkout
      recent_branch_names = GitRecent::BranchLister.new.branch_names

      abort 'No recent branches' if recent_branch_names.empty?

      chooser = GitRecent::BranchChooser.new recent_branch_names
      selected_branch = chooser.request_choice

      if selected_branch
        system `git checkout #{selected_branch}`
      end
    end
  end
end
