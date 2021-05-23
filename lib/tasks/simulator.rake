namespace :simulator do
  desc "TESTS THE SIMULATOR"
  task :run, [:file_name] => :environment do |task, args|
    file_name = Rails.root.join(args[:file_name].to_s)
    RobotMovementTester.call(file_name)
  end
end


