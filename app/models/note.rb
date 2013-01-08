class Note < ActiveRecord::Base
  
  belongs_to :customer
  attr_accessible :text, :title, :customer_id

  def created_time
  	t = created_at
  	t.strftime("%H:%M %d-%m-%Y")
  end
end
