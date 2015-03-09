class SessionsController < ApplicationController

  def new
  end

    def create
  	user=User.find_by(email: params[:session][:email].downcase)
  	if user&&user.authenticate(params[:session][:password])
      if user.activated?
  		  log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user
      else
        flash[:danger] = "Слышь почту проверь ,а то что не активировалось . "
        redirect_to root_url
      end
  	else
  		flash[:danger]="Something wrong in name/email!"
  		render 'new'
  	end
  end

  def destroy
  	log_out if log_in?
  	redirect_to root_url
  end
end
