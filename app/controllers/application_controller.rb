require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

  get '/students' do
    @students = Student.all
    erb :'students/index'
  end

  get '/students/new' do
    erb :'students/new'
    end
    
    post '/students' do
      
    @student = Student.new(params[:student])
    
    if @student.save
      redirect '/students'
    else 
      erb :'students/new'
     end
    end

  get '/students/:id' do
  @student = Student.find(params[:id])
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
