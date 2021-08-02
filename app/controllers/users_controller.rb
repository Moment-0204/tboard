class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if !User.find_by(name: params[:user][:name]) then
      @user = User.new(name:params[:user][:name],password:params[:user][:password],password_confirmation:params[:user][:password_confirmation],mod:1)
      if @user.save
        log_in(@user)
        flash[:success] = '新しいユーザーを登録しました。'
        redirect_to '/'
      else
        flash[:danger] = 'ユーザーの登録に失敗しました。'
        redirect_to '/new_user'
      end
    else
      flash[:danger]='同名のユーザーがいます。名前を変更してください。'
      redirect_to '/new_user'
    end
  end
end