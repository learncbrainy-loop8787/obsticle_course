class CoursesController < ApplicationController

  get '/courses/new' do
    if logged_in?
      erb :'/courses/create_course'
    else
      redirect to '/'
    end
  end

  post '/courses' do
    @courses = Course.new(teacher: Teacher.find_or_create_by(name: params[:teacher][:name].strip, user_id: current_user.id),
                              location: params[:location].strip,
                              course_date: Date.parse(params[:course_date]),
                              description: params[:description].strip,
                              course_price: params[:course_price].to_f)
         if @course.save && @course.teacher.valid?
      redirect to "/courses/#{@course.id}"
    else
      redirect to '/courses/new'
    end
  end

  get '/courses/:id' do
    @course = Course.find_by_id(params[:id])
    erb :'/courses/show_course'
  end

  get '/courses/:id/edit' do
    @course = Course.find_by_id(params[:id])
    if logged_in? && current_user.courses.include?(@concert)
      erb :'/courses/edit_course'
    else
      redirect to "/courses/#{@course.id}"
    end
  end

  patch '/courses/:id' do
    @course = Course.find_by_id(params[:id])
    @course.teacher = Teacher.find_or_create_by(name: params[:teacher][:name].strip, user_id: current_user.id)
    @course.location = params[:location].strip
    @course.course_date = Date.parse(params[:course_date])
    @course.description = params[:description].strip
    @course.course_price = params[:course_price].to_f
    if logged_in? && current_user.courses.include?(@course)
      @course.save
      redirect to "/courses/#{@course.id}"
    else
      redirect to "/courses/#{@course.id}"
    end
  end

  delete '/courses/:id' do
    @course = Course.find_by_id(params[:id])
    if logged_in? && current_user.courses.include?(@course)
      @course.delete
      redirect to "/users/#{current_user.id}"
    else
      redirect to "/courses/#{@course.id}"
    end
  end
end
