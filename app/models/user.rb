class User < ApplicationRecord
  #フレンドのデータベース関連
  has_many :friends
  has_many :following, through: :friends, source: :follower
  has_many :followed, through: :friends, source: :followed
  
  #イベント参加者のデータベース関連
  has_many :participants
  has_many :events, through: :participants
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, :confirmable,
         :authentication_keys => [:login]
          

  mount_uploader :img, ImgUploader
  attr_accessor :login

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

  #deviseのログイン認証のメソッドをオーバーライド
  #usenameとemailの片方でログイン可能
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end

     
  private 
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end