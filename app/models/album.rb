class Album < ActiveRecord::Base
  has_many :photos, :dependent => :destroy
  attr_accessible :cover, :title, :photos
end
