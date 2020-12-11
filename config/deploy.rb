# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "lootauvore"
set :repo_url, "git@github.com:Cruder/Lootovore.git"

set :deploy_to, -> { "/data/#{fetch(:application)}" }

set :ssh_options, {
  forward_agent: true,
  keys: [
    File.join(ENV['HOME'], '.ssh', 'id_rsa')
  ]
}

set :keep_releases, 5
