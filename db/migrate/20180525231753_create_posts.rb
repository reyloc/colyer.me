class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.string :keywords
      t.string :description
      t.integer :public, null: false, default: 0
      t.timestamps
    end
  end
end
