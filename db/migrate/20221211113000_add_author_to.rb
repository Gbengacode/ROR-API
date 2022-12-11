class AddAuthorTo < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :author
  end
end
