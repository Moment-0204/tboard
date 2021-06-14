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
    # 削除するコメントを指定せずボタンを押したときはparams[:review]がnilで返ってくる
    unless params[:review].nil?
      # delete_id->削除するコメントのid(本体)
      # delete_innerid->削除するコメントのinnerid(科目・教員・コメントがセットでわかる)
      # innerid->abbccのかたちでa:科目,b:教員,c:コメントになっている
      delete_id = params[:review][:id]
      delete_innerid = Review.find(delete_id).innerid
      delete_title = delete_innerid / 100
      reviews = Review.order(:innerid).all
      # inneridの下２桁が00のときはその教員名もセットで持っているので01に譲ったあとinneridを1ずつ下げてやる
      # その他のときは単純にinneridを1ずつ下げてやるだけで良い
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
    # 科目に応じてinneridの大枠を決める
    # 科目を指定しなかったときは無視するため0を設定する
    makeinnerid = case params[:review][:class]
                  when '数理科学基礎'
                    10_000
                  when '物性化学'
                    20_000
                  else
                    0
                  end
    unless makeinnerid.zero?
      reviews = Review.order(:innerid).all
      # すでにコメントの付いている教員であれば，その教員の全コメントのうち最後尾に新しいコメントを追加する
      # コメント付きの教員の場合，00はtitleとしてその教員名を持っているが01以降はtitleが空なのでinneridの上３桁で判別するしかない
      reviews.each do |r|
        if r.title == params[:review][:title] || (makeinnerid % 100 == 1 && makeinnerid / 100 == r.innerid / 100)
          makeinnerid = r.innerid + 1
        end
      end
      # まだコメントの付いていない教員の場合は，inneridのbbの部分を新たに付与するためにbbの最後尾を調べてそれ+1を設定する
      if (makeinnerid % 10_000).zero?
        reviews.each do |r|
          makeinnerid = (r.innerid / 100 + 1) * 100 if r.innerid / 10_000 == makeinnerid / 10_000
        end
      end
      # コメントの付いている教員の場合はtitleは空で良い
      params[:review][:title] = '' if makeinnerid % 100 != 0
      Review.create(title: params[:review][:title], content: params[:review][:content], innerid: makeinnerid)
    end
    redirect_to '/review/show'
  end
end
