class CreateRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :requirements do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
