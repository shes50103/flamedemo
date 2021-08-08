class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :body
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end
