module GitRecent
  require 'thor'

  class Cli < Thor
    desc 'list', 'list recently checked-out git branches'
    def list
    end
  end
end
