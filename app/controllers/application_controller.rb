# frozen_string_literal: true

$visitTime = 0

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  def index; end

  def sub; end

  def reset
    $visitTime = 0
    redirect_to '/'
  end

  def sub1
    $visitTime += 1
    p $visitTime
  end

  private
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      redirect_to '/login'
    end
  end
end
