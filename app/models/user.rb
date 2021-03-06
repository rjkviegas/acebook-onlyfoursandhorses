class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :wallposts, dependent: :destroy
  has_many :postcomments
  has_secure_password
  before_save { self.email = email.downcase }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  before_create :slugify

  def to_param
    slug
  end

  def slugify
    self.slug = name.parameterize
  end
end
