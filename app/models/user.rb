class User < ApplicationRecord
  has_many :friends, class_name:  "Friend",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :following, through: :friends, source: :followed
  has_many :followed, through: :friends, source: :follower
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable
        
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
       user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        username: auth.info.name,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
      )
    end
    user
  end

  def self.follow(follower_id, followed_id)
    #すでにデータベースに登録されていなければ新規登録する
    if (Friend.where(follower_id: follower_id, followed_id: followed_id).empty?)&&
       (Friend.where(follower_id: followed_id, followed_id: follower_id).empty?)
      Friend.create(follower_id: follower_id, followed_id: followed_id)
      Friend.create(follower_id: followed_id, followed_id: follower_id)
    end
  end

  def self.unfollow
  end

  def self.friend(id)
    User.find(id).following
  end

     
  private 
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end