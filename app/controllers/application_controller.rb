class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from ActiveRecord::RecordNotFound, :with => :rescue_not_found
  
  protect_from_forgery with: :exception
    
  protected
  def rescue_not_found
  	flash[:notice] = "Record not found"
  	redirect_to(:action =>'index')
    #render :template => 'application/not_found', :status => :not_found
  end

  private # so only this class can call it.
  
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'access', :action => 'login')
      return false #halts the before_action
    else
      return true
    end
  end
end
