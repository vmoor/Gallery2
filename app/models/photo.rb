class Photo < ActiveRecord::Base
  belongs_to :album
  attr_accessible :album_id, :image

  mount_uploader :image, ImageUploader

  include Rails.application.routes.url_helpers

  def to_jq_image
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb.url,
      "delete_url" => album_photo_path(:album_id => album_id, :id => id),
      "delete_type" => "DELETE"
    }
  end
end
