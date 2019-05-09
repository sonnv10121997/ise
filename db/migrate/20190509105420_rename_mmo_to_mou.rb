class RenameMmoToMou < ActiveRecord::Migration[5.2]
  def change
    rename_table :mmos, :mous
  end
end
