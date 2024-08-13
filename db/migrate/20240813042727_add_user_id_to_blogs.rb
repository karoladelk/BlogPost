class AddUserIdToBlogs < ActiveRecord::Migration[6.1]
  def change
    add_reference :blogs, :user, foreign_key: true, null: true
  end
end
