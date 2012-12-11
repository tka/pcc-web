class CreateProcurements < ActiveRecord::Migration
  def change
    create_table :procurements do |t|
      t.integer :procuring_entity_id
      t.string  :job_number
      t.string  :subject
      t.integer :price
      t.text    :url
      t.timestamps
    end
    add_index :procurements, :procuring_entity_id
  end
end
