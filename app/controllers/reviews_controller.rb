class ReviewsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def show
    @reviews = Review.order(:innerid).all
  end

  def new
    @review=Review.new
  end

  def create
    makeinnerid=0
    case params[:review][:class]
    when "数理科学基礎" then
      makeinnerid=10001
    when "物性化学" then
      makeinnerid=20001
    end
    Review.create(title: params[:review][:title], content: params[:review][:content], innerid:makeinnerid)
    redirect_to "/review/show"
  end
end
