namespace :dev do
  
  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')
  
  desc "Configure the development environment"
  task setup: :environment do
    if Rails.env.development?
      spinner = TTY::Spinner.new("[:spinner] Loading ...", format: :classic)
      spinner.auto_spin
      puts %x(rails db:drop db:create db:migrate dev:add_default_admin dev:add_extra_admin dev:add_default_user dev:add_subjects)
      spinner.stop("(Successful)")
    else
      puts 'You are not in development environment!'
    end    
  end

  desc "Add the default admin"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
      )
  end

  desc "Add extras admins"
  task add_extra_admin: :environment do
    10.times do |n|
      Admin.create!(
      email: Faker::Internet.email,
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Add the default user"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
      )
  end

  desc "Add the subjects"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end
end