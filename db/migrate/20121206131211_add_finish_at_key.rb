class AddFinishAtKey < ActiveRecord::Migration
  def change
    add_index :procurements, :finish_at
  end

end
