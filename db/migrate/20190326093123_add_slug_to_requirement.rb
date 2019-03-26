class AddSlugToRequirement < ActiveRecord::Migration[5.2]
  def change
    add_column :requirements, :slug, :string
    add_index :requirements, :slug, unique: true
  end
end
