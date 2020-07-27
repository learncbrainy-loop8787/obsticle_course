class Teacher < ActiveRecord::Base
  has_many :courses
  belongs_to :user

  validates :name, :user, presence: true
  validates :name, uniqueness: true

  def slug
    self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    Teacher.all.detect {|x| slug == x.slug}
  end
end
