class Post < ApplicationRecord
  has_many :categories_posts, :dependent => :destroy

  has_many :categories, through: :categories_posts

  belongs_to :user
  has_many :comments, :dependent => :destroy

  has_many :collects, :dependent => :destroy

  mount_uploader :image, PhotoUploader

end
