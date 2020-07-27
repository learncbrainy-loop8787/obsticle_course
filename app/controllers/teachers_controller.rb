class TeachersController < ApplicationController
  get '/teachers' do
    @teachers = Teacher.all
    erb :'/teachers/teachers'
  end

  post '/teachers' do
    @teacher = current_user.teachers.new(name: params[:name].strip, bio: params[:bio])
    if @teacher.save
      redirect to "/teachers/#{@teacher.slug}"
    else
      redirect to '/teachers/new'
    end
  end

  get '/teachers/new' do
    if logged_in?
      erb :'/teachers/create_teacher'
    else
      redirect to '/'
    end
  end

  get '/teachers/:slug' do
    @teacher = Teacher.find_by_slug(params[:slug])
    erb :'/teachers/show_teacher'
  end

  get '/teachers/:slug/edit' do
    @teacher = Teacher.find_by_slug(params[:slug])
    if logged_in? && current_user.teachers.include?(@teacher)
      erb :'/teachers/edit_teacher'
    else
      redirect to "/teachers/#{@teacher.slug}"
    end
  end

  patch '/teachers/:slug' do
    @teacher = Teacher.find_by_slug(params[:slug])
    @teacher.name = params[:name]
    @teacher.bio = params[:bio]
    if logged_in? && current_user.teachers.include?(@teacher) && @teacher.valid?
      @teacher.save
      redirect to "/teachers/#{@teacher.slug}"
    else
      redirect to "/teachers/#{@teacher.slug}"
    end
  end

  delete '/teachers/:slug' do
    @teacher = Teacher.find_by_slug(params[:slug])
    if logged_in? && current_user.teachers.include?(@teacher)
      @teacher.courses.each do |course|
        course.delete
      end
      @teacher.delete
      redirect to "/users/#{current_user.id}"
    else
      redirect to "/teachers/#{@teacher.slug}"
    end
  end
end
