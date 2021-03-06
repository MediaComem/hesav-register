set :application, 'hesav-forms'
set :domain, 'webwww06'
set :deploy_to, '/srv/www/hesav-forms'
set :repository, 'https://github.com/MediaComem/hesav-register.git'
set :revision, 'origin/master'
set :skip_scm, false
set :sudo_flags, sudo_flags << '-S'
set :run_as_sudo, [sudo_cmd, sudo_flags].flatten.compact.join(' ')

namespace :vlad do

  desc "Clean scm repo"
  remote_task :clean_scm_repo do
    run "rm -rf #{scm_path}/repo"
  end

  desc "Bundle update"
  remote_task :bundle_update do
    run "source ~/.rvm/scripts/rvm && cd #{current_path} && bundle --without development test"
  end

  desc "Precompile assets"
  remote_task :precompile_assets do
    run "rm -rf #{current_path}/public/assets"
    run "source ~/.rvm/scripts/rvm && cd #{current_path} && RAILS_ENV=production bundle exec rake assets:precompile"
  end

  desc "Copy .env file"
  remote_task :copy_env do
    rsync ".env.production", "#{current_path}/.env"
  end

  desc "Refresh Passenger"
  remote_task :refresh_passenger do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Migrate Database"
  remote_task :migrate_iregister_db do
    run ["source ~/.rvm/scripts/rvm",
          "cd #{current_path}",
          "RAILS_ENV=production bundle exec rake db:migrate"
        ].join(" && ")
  end

  desc "Full deployment cycle"
  remote_task :deploy => %w(
    vlad:clean_scm_repo
    vlad:update
    vlad:bundle_update
    vlad:precompile_assets
    vlad:copy_env
    vlad:migrate_iregister_db
    vlad:refresh_passenger
  )
end
