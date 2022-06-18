class RegistrationsController < Devise::RegistrationsController

  def new
    user = User.new(user_params)
  end
         
  def create
    @user = User.new(user_params)

    if @user.save 
      current_user = @user
      render json: {data: @user }, status: :ok
    else 
      render json: {status: "ERROR", 
                      message: "Could not create new user account", 
                      data: @user.errors}, 
                      status: :unprocessable_entity
      end
    end
  
    private 
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    end
  end
  