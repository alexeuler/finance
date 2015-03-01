require_relative '../sitemap'

namespace :sitemap do
  desc "create sitemap"
  task :generate => :environment do
    Sitemap::generate
  end
end