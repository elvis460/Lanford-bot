class BackendsController < ApplicationController
  before_action :check_admin_login

  def index
    
  end
  
  private
  def check_admin_login
    if session[:admin].blank?
      redirect_to backends_sessions_path
      return
    else  
      @admin_login = Admin.find(session[:admin])
    end
  end
end
