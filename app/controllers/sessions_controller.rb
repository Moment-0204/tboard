class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success]='ログイン成功！'
      redirect_to '/'
    else
      flash.now[:danger]='名前またはパスワードが間違っています。'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to '/'
  end

end
