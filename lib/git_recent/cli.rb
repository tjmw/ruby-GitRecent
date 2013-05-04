module GitRecent
  require 'thor'

  class Cli < Thor
    desc 'list', 'list recently checked-out git branches'
    def list
      recent_branch_names = GitRecent::BranchLister.new.branch_names

      if !recent_branch_names.empty?
        recent_branch_names.each do |branch_name|
          puts branch_name
        end
      else
        puts 'No recent branches'
      end
    end
  end
end
