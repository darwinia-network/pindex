namespace :data do
  desc 'Clear'
  task clear: [:environment, 'db:drop', 'db:create', 'db:migrate', 'data:rm_files']

  desc 'Remove files under dir .pindex'
  task rm_files: :environment do
    puts '== Remove files under dir .pindex'
    `rm -f #{Rails.root}/.pindex/*`
  end
end
