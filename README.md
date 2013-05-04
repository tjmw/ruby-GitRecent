# GitRecent

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'git_recent'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git_recent

## Usage

	$ git_recent
    Commands:
      git_recent help [COMMAND]  # Describe available commands or one specific command
      git_recent list            # list recently checked-out git branches

I like to alias the following in my .gitconfig:

	[alias]
	  recent = ! git_recent list

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
