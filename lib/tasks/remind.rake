namespace :remind do
    desc '挨拶するメールを発行する。'
    task say_hello: :environment do
        users = User.first  # テスト用に自分のアカウントのみにメール送信
    
        users.each do |user|
        UserMailer.remind(user).deliver
        end
    end
end
