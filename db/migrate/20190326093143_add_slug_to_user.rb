class AddSlugToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :slug, :string, null: false
    add_index :users, :slug, unique: true
  end
end
