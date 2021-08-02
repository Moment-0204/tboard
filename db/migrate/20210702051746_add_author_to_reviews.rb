class AddAuthorToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :author, :string
  end
end
