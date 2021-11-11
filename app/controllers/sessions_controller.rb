class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])

    # if the user exists AND the password entered is correct.
    if @user && @user.authenticate(params[:password])

      # save the user id insiode the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = @user.id
      redirect_to "/"
    else
      # if user's login doesn't work, send them back to the login form
      flash[:error] = 'User with the input details not found, please register first to continue'
      redirect_to :login
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :login
  end

end
