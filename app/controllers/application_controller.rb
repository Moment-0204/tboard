$visitTime=0

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
#    render plain: "railsはクソ！w"
  end
  
  def sub
  end

  def reset
    $visitTime=0
    redirect_to "/"
  end

  def sub1
    $visitTime += 1
    p $visitTime
  end

end
