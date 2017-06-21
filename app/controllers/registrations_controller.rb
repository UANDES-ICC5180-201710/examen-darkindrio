class RegistrationsController < Devise::RegistrationsController
 skip_before_filter :require_no_authentication, only: [:new, :create]
 before_filter :authenticate_user!
 
 def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
     redirect_to games_path
    else
     render :new
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :is_staff)
  end

  
  
end
