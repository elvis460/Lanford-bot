class Backends::SessionsController < BackendsController
  skip_before_action :check_admin_login
  
  def index
    render layout: false
  end

  def create   
    @admin = Admin.find_by(name: params[:name])
    if @admin && @admin.authenticate(params[:password])
      session[:admin] = @admin.id
      redirect_to backends_path,flash: {success: "login success!"}
    else
      render json: 'no'
      return
      redirect_to backends_path,flash: {error: "login failed!"}
    end
  end

  def destroy
    session[:admin] = nil
    redirect_to backends_path,flash: {success: "logout success!"}
  end
end
