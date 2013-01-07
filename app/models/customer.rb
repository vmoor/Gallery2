class Customer < ActiveRecord::Base
  has_many :albums, dependent: :destroy
  belongs_to :user
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :user_id, :password_visible, :username, :login

  attr_accessor :login

  validates :username, presence: true, :uniqueness => true
  validates :name, presence: true

  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
  end


  before_validation do
    unless username
      uname = 'user-' + user_id.to_s + rand(10**3).to_s(10)

      while (Customer.where(username: uname).count > 0) do
        uname = 'user-' + user_id.to_s + rand(10**3).to_s(10)
      end
      self.username = uname
    end
  end

end
