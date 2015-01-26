namespace :export do
  desc 'Exports Tasks'
  task :tasks => :environment do
    HEADER_NAMES = ['title', 'is_completed']

    csv_file = CSV.open('tasks.csv','wb')
    csv_file << HEADER_NAMES

    Task.all.each do |task|
      data = task.attributes.slice(*HEADER_NAMES)
      data = task.attributes.slice('title', 'is_completed')
      csv_file << data.values
    end
  end

  desc 'Exports Projects'
  task :projects => :environment do
    HEADER_NAMES = ['team', 'title']

    csv_file = CSV.open('lib/tasks/project_all.csv','wb')
    csv_file << HEADER_NAMES

    Project.all.each do |project|
      data = project.attributes.slice(*HEADER_NAMES)
      data = project.attributes.slice('team', 'title')
      csv_file << data.values
    end
  end
end
