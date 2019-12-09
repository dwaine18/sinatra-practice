class SessionsController < ApplicationController

    post '/login' do
     @student = Student.find_by(email: params[:email])
     if @student.authenticate(params[:password])
        session[:user_id] = @student.id
        redirect "/students/#{@student.id}"
     end
    end
    get '/signup' do
        erb :signup
    end
    
    post '/students' do

        if params[:name] != "" && params[:email] != "" && params[:password] != ""
               @student = Student.create(params[:students])
            redirect "/students/#{@student.id}"
          else
            erb :signup
    end
end
end

