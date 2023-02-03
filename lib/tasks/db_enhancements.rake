# frozen_string_literal: true

namespace :db do
  task dev_setup: :environment do
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
  end
end
