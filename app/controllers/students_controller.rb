class StudentsController < ApplicationController
    get '/students' do
        @students = Student.all
        erb :'students/index'
      end
    
    get '/students/:id' do
      @student = Student.find(params[:id])
      #finding the applications submitted by the current user.
      session[:user_id] = @student.id
      
      
      
      erb :'students/show'
    end
    
     get '/students/:id/edit' do
      if authorize?(@student)
      @student = Student.find(params[:id])
      erb :'students/edit'
      else
        erb :noaccess
      end
    end
    
     patch "/students/:id" do
      @student = Student.find(params[:id])
      
      if @student.id == current_user.id 
      @student.update(params[:students])
    
      redirect "/students/#{@student.id}"
      else 
        redirect '/'
      end
    end
    
    delete '/students/:id' do
      
    @student = Student.find(params[:id])
    if authorize?(@student)
      @student.destroy
      redirect '/'
    else
      erb :noaccess
    end 
    end  
    
    #Helper to limit edit and delete rights
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
