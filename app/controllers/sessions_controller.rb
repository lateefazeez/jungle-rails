class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # Check if user is authenticated
    if @user = User.authenticate_with_credentials(params[:email], params[:password])
      # save the user id inside the browser cookie. This is how we keep the user 
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
