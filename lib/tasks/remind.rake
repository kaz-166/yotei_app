namespace :remind do
    desc '挨拶するメールを発行する。'
    task :remind => :environment do
        user = User.first  # テスト用に自分のアカウントのみにメール送信
        UserMailer.remind(user).deliver
    end
end
