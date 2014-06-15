# Parameters:
# APPLICATION - app name
# SCM_SERVER - git server domain name or ip
# SCM_NAMESPACE - git namespace
# BRANCH - branch to deploy from
# RAILS_ENV - environment (staging, production, etc)
# DEPLOY_HOME - where deploy folder will be placed (suffixed by RAILS_ENV)
# CUSTOM_FOLDER - custom folder to deploy to
# SERVERS - servers to deploy to, separated by com
# MODULES - additional modules to load for deploy

Deploy::Code.within_capistrano do

  raise 'APPLICATION is not specified' unless ENV['APPLICATION']
  raise 'SCM_SERVER is not specified' unless ENV['SCM_SERVER']
  raise 'SCM_NAMESPACE is not specified' unless ENV['SCM_NAMESPACE']
  raise 'SERVERS is not specified' unless ENV['SERVERS']

  set :application, ENV['APPLICATION']

  set :scm, :git
  set :repository,  "git@#{ENV['SCM_SERVER']}:#{ENV['SCM_NAMESPACE']}#{application}"
  set :branch, ENV['BRANCH'] || 'master'

  set :deploy_to, "#{ENV['DEPLOY_HOME'] || '/home/user/projects'}-#{ENV['RAILS_ENV'] || 'staging'}/#{ENV['CUSTOM_FOLDER'] || application}"

  set :use_sudo, false
  default_run_options[:pty] = true
  set :ssh_options, { forward_agent: true }
  set :normalize_asset_timestamps, false
  set :git_shallow_clone, 1

  ENV['SERVERS'].split(',').each do |server|
    role :app, server
  end

end

(ENV['MODULES'] || '').split(',').each do |name|
  require "deploy/code/modules/#{name}"
end

