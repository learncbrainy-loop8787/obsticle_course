class Course < ActiveRecord::Base
  belongs_to :teacher
  has_one :user, through: :teacher

  validates :course_price, :course_date, :location, :teacher_id, presence: true
end
