class AddSlugToPartner < ActiveRecord::Migration[5.2]
  def change
    add_column :partners, :slug, :string
    add_index :partners, :slug, unique: true
  end
end
