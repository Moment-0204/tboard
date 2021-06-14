class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(name:params[:user][:name],password:params[:user][:password],password_confirmation:params[:user][:password_confirmation],mod:0)
    if @user.save
      flash[:success] = '新しいユーザーを登録しました。'
      redirect_to '/'
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end

end