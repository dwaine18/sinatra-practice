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

  
#  University  Applications Section
#Check to see if user is logged in to create a new application.
get'/applications/new' do
  
  if logged_in?
    
  @applications = Application.all
  @programs = Program.all

  erb :'applications/new'
    elsif !authorize?
      erb :noaccess
  else 
    redirect "/"
  end
end

post '/applications' do
  #get entire program object
  @program = Program.find_by(program_name: params[:application][:program_name])
  # session[:user_id] = @student.id

  #create new application linking program with current user
  @application = Application.create(student_id: current_user.id, program_id: @program.id)
  
  
  redirect "/students/#{current_user.id}"
  
end
#Show all applications
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


 helpers do
      def logged_in?
        !!current_user
      end
      def current_user
        Student.find_by(id: session[:user_id])
      end
    
    def authorize?(student)
        @student == current_user.id
    end
  end
end
