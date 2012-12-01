class CreateProcuringEntities < ActiveRecord::Migration
  def change
    create_table :procuring_entities do |t|
      t.string :entity_code
      t.string :name 
      t.timestamps
    end
  end
end
