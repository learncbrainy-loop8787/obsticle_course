class User < ActiveRecord::Base
  has_many :teachers
  has_many :courses, through: :teachers

  validates :email, :password, :username, presence: true
  validates :email, :username, uniqueness: true

  def authenticate(password)
    if self.password == password
      self
    else
      false
    end
  end

end
