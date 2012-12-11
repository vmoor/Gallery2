class Album < ActiveRecord::Base
  has_many :photos, :dependent => :destroy
  belongs_to :customer
  attr_accessible :cover, :title, :photos, :customer_id
  validates :title, presence: true, :uniqueness => true
  validates :customer_id, presence: true
end
