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
      "delete_url" => user_customer_album_photo_path(:user_id => album.customer.user_id, :customer_id => album.customer_id , :album_id => album_id, :id => id),
      "delete_type" => "DELETE"
    }
  end
end
