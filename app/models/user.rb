class User < ApplicationRecord
  mount_uploader :profile_picture, ProfilePictureUploader
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [ :google_oauth2 ]

  has_many :events, dependent: :destroy # ユーザーが削除された時、Eventレコードも削除される
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_events, through: :bookmarks, source: :event

  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
end
