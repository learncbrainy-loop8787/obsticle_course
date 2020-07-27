3.times do |i|
  @user = User.create(username: "user#{i+1}", email: "user#{i+1}@user.com", password: "test")
  @teacher = @user.teachers.create(name: "teacher#{i+1}", bio: "Smarter, Faster, Stronger.", user_id: i+1)
  3.times do |j|
    Course.create(course_price: 15.00, location: "location#{j+1}", course_date: "Jan #{j+3}, 2017", description: "fixing things all the time.",  teacher_id: i+1)
  end
end
