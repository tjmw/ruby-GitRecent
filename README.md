# GitRecent

[![Build Status](https://travis-ci.org/tjmw/ruby-GitRecent.png)](https://travis-ci.org/tjmw/ruby-GitRecent)
[![Code Climate](https://codeclimate.com/github/tjmw/ruby-GitRecent.png)](https://codeclimate.com/github/tjmw/ruby-GitRecent)

Command line tool (wrapped in a gem) for displaying and interacting with recently checked-out
git branches

## Installation

    $ gem install git_recent

## Usage

	$ git_recent
    Commands:
      git_recent checkout        # Interactively checkout a recently checked-out git branch
      git_recent help [COMMAND]  # Describe available commands or one specific command
      git_recent list            # List recently checked-out git branches
      git_recent version         # Print version information

    Options:
      [--max=N]
                # Default: 5

I like to alias the following in my .gitconfig:

	[alias]
      rl = ! sh -c 'git_recent list'
      rc = ! sh -c 'git_recent checkout'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
