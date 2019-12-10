class SessionsController < ApplicationController
    # This sessions controller displays all information pertaining to user creation, passwords and sessions
    post '/login' do
     @student = Student.find_by(email: params[:email])

     if params[:email] !="" && params[:password] !=""
         if params[:email] !="email" && params[:password] !="password"
            # @student.authenticate(params[:password])
            if !@student.authenticate(params[:password])
                redirect '/'
            elsif 
                @student.authenticate(params[:password])
                session[:user_id] = @student.id
                redirect "/students/#{@student.id}"
             end
         else
            redirect '/'
         end
        
     else 
        redirect '/'
     
     end
    end

    get '/signup' do
        erb :signup
    end

    # old students sign up route
    get '/students/new' do
        erb :signup
    end
    
    post '/students' do

       
        # if params[:name] !="" && params[:email] !="" && params[:password] !=""
           if @student = Student.create(params[:students])
               session[:user_id] = @student.id
               redirect "/students/#{@student.id}"
          else
            redirect '/signup'
        end
    end
   #fallthrough to show sign up form again
        get '/students/' do
            erb :signup
        end

       get '/logout' do
           session.clear
           redirect '/'
       end
end

