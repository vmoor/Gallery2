class Photo < ActiveRecord::Base
  belongs_to :album
  attr_accessible :album_id, :image

  mount_uploader :image, ImageUploader
end
