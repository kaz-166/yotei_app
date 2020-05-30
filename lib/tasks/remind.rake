namespace :remind do
    desc '挨拶するメールを発行する。'
    task :remind => :environment do
        User.all.each do |user|
            UserMailer.remind(user).deliver
        end
    end
end
