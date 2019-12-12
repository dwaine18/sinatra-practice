require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "admissions_advice_app"
  end
  
  helpers do
    def logged_in?
      !!current_user
    end
    def current_user
      Student.find_by(id: session[:user_id])
    end
  end

  get "/" do
    if logged_in?
        redirect "/students/#{current_user.id}"
    else
    erb :welcome
    end
  end

  get '/students' do
    @students = Student.all
    erb :'students/index'
  end

  
    # New student route in Sessions Controller
    # post '/students' do
      
    # @student = Student.new(params[:student])
    
    # if @student.save
    #   redirect '/students'
    # else 
    #   erb :'students/new'
    #  end
    # end

  get '/students/:id' do
  @student = Student.find(params[:id])
  #finding the applications submitted by the current user.
  session[:user_id] = @student.id
  
  
  
  erb :'students/show'
end

 get '/students/:id/edit' do

  @student = Student.find(params[:id])
  erb :'students/edit'
end

 patch "/students/:id" do
  @student = Student.find(params[:id])
  
  @student.update(params[:students])

  redirect "/students/#{@student.id}"
end

delete '/students/:id' do
  @student = Student.find(params[:id])
  
  @student.destroy
  redirect '/students'

end  
# Applications Section

get'/applications/new' do

  @applications = Application.all
  @programs = Program.all

  erb :'applications/new'

end
post '/applications' do
  #get entire program object
  @program = Program.find_by(program_name: params[:application][:program_name])
  session[:user_id] = @student.id

  #create new application linking program with current user
  @application = Application.create(student_id: current_user.id, program_id: @program.id)
  
  
  redirect "/students/#{current_user.id}"
  
end
get '/applications' do

  @applications = Application.all #define instance variable for view

  erb :'applications/index' #show all applications view (index)

end

#edit the application
get '/applications/:id/edit' do
  
    @application = Application.find(params[:id])
    erb :'students/show'
  end
  
  
  patch "/applications/:id" do
    
    @application = Application.find(params[:id])
    
    @application.update(params[:application])
  
    redirect "/applications/#{@application.id}"
  end

get '/applications/:id' do


  #gets params from url

  @application = Application.find(params[:id]) #define instance variable for view

  erb :'applications/show' #show single application view

end




end
