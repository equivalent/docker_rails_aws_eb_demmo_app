# Change to match your CPU core count
workers ENV.fetch('WEB_CONCURRENCY')

# Min and Max threads per worker
threads 1, ENV.fetch('MAX_THREADS')

app_dir = File.expand_path("../..", __FILE__)

pid_dir = "/var/run/archiveapp"
log_dir = "/var/log/archiveapp"

rails_env = ENV.fetch('RAILS_ENV')
environment rails_env

bind "unix://#{pid_dir}/puma.sock?umask=0000"

stdout_redirect "#{log_dir}/puma.stdout.log", "#{log_dir}/puma.stderr.log", true

pidfile "#{pid_dir}/puma.pid"
state_path "#{pid_dir}/puma.state"

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end

