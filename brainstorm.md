# General
 * add some constraints, checks of existing routes
 * automount of isolated engines (provide hot mount on routes draw)

# Installing gem and loading in run time

## Install ideas

    # Bundler to manage dependencies
    _bundle_command = Gem.bin_path('bundler', 'bundle')

    require 'bundler'
    Bundler.with_clean_env do
      print `"#{Gem.ruby}" "#{_bundle_command}" #{command}`
    end

    # Steps for engines with migrations
    $ rake blorgh:install:migrations # copy migrations from engine to app folder
    $ rake db:migrate

## Uninstall ideas

TODO (no idea! :X)

## Update ideas

Check for new version.
See cases with migration ... :o
Remove && Install ... correct?
