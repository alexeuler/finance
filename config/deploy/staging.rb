# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

set :application, 'finance_staging'
set :root, "/var/www/#{fetch(:application)}/current"


website_url='lovimagaz.ru'
ssh_user='deployment'


role :app, [ssh_user+"@"+website_url]
role :web, [ssh_user+"@"+website_url]
role :db, [ssh_user+"@"+website_url]


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server website_url, user: ssh_user, roles: %w{web app}, my_property: :my_value


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }


namespace :db do
  task :clone do
    on ssh_user+"@"+website_url do
      db_dump = "#{fetch(:root)}/tmp/db_dump"
      execute "sudo /etc/init.d/thin stop_single /etc/thin/#{fetch(:application)}.yml"
      execute "pg_dump finance_production > #{db_dump}"
      execute 'dropdb finance_staging'
      execute 'createdb finance_staging'
      execute "psql finance_staging < #{db_dump}"
      execute "rm #{db_dump}"
      execute "sudo /etc/init.d/thin start_single /etc/thin/#{fetch(:application)}.yml"
    end
  end
end

namespace :deploy do
  after :published, 'db:clone'
end

