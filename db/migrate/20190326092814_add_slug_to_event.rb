class AddSlugToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :slug, :string
    add_index :events, :slug, unique: true
  end
end
