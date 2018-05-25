class CreatePostContents < ActiveRecord::Migration[5.2]
  def change
    create_table :post_contents do |t|
      t.references :post, foreign_key: true
      t.string :content
      t.timestamps
    end
  end
end
