class CreateNotes < ActiveRecord::Migration[7.2]
  def change
    create_table :notes do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :blog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
