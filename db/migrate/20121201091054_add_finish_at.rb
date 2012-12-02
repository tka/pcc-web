class AddFinishAt < ActiveRecord::Migration
  def up
    add_column :procurements, :finish_at, :datetime
  end

  def down
  end
end
