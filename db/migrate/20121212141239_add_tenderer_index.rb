class AddTendererIndex < ActiveRecord::Migration
  def up
    add_index :tenderers, :name, :length => 5
  end

  def down
    remove_index :tenderers, :name
  end
end
