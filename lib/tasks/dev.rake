namespace :dev do
  
  DEFAULT_PASSWORD = 123456
  
  desc "Configure the development environment"
  task setup: :environment do
    if Rails.env.development?
      spinner = TTY::Spinner.new("[:spinner] Loading ...", format: :classic)
      spinner.auto_spin
      puts %x(rails db:drop db:create db:migrate dev:add_default_admin dev:add_extra_admin dev:add_default_user)
      spinner.stop("(successful)")
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
end