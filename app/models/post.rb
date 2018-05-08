class Post < ApplicationRecord
  has_and_belongs_to_many :categories
  mount_uploader :image, PhotoUploader
  belongs_to :user, dependent: :destroy
end
