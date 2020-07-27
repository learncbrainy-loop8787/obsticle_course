class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.belongs_to :teacher
      t.datetime :course_date
      t.string :location
      t.string :description
      t.float :course_price
    end
  end
end
