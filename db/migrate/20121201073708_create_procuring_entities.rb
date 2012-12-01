class CreateProcuringEntities < ActiveRecord::Migration
  def change
    create_table :procuring_entities do |t|

      t.timestamps
    end
  end
end
