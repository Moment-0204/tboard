# frozen_string_literal: true

class ReviewsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def show
    @reviews = Review.order(:innerid).all
  end

  def new
    @review = Review.new
  end

  def delete
    @delete_review = Review.new
    @reviews = Review.order(:innerid).all
  end

  def exc_delete
    unless params[:review].nil?
      delete_id = params[:review][:id]
      delete_innerid = Review.find(delete_id).innerid
      delete_title = delete_innerid / 100
      reviews = Review.order(:innerid).all
      if (delete_innerid % 100).zero?
        reviews.each do |r|
          if r.innerid == delete_innerid + 1
            r.title = Review.find(delete_id).title
            r.innerid -= 1
            r.save
          elsif r.innerid / 100 == delete_title
            r.innerid -= 1
            r.save
          end
        end
      else
        reviews.each do |r|
          if r.innerid / 100 == delete_title && r.innerid > delete_innerid
            r.innerid -= 1
            r.save
          end
        end
      end
      Review.find(delete_id).destroy
    end
    redirect_to '/review/show'
  end

  def create
    makeinnerid = 0
    makeinnerid = case params[:review][:class]
                  when '数理科学基礎'
                    10_000
                  when '物性化学'
                    20_000
                  else
                    0
                  end
    unless makeinnerid == 0 then
      reviews = Review.order(:innerid).all
      reviews.each do |r|
        if r.title == params[:review][:title] || (makeinnerid % 100 == 1 && makeinnerid / 100 == r.innerid / 100)
          makeinnerid = r.innerid + 1
        end
      end
      if (makeinnerid % 10_000).zero?
        reviews.each do |r|
          makeinnerid = (r.innerid / 100 + 1) * 100 if r.innerid / 10_000 == makeinnerid / 10_000
        end
      end
      params[:review][:title] = '' if makeinnerid % 100 != 0
      Review.create(title: params[:review][:title], content: params[:review][:content], innerid: makeinnerid)
    end
    redirect_to '/review/show'
  end
end
