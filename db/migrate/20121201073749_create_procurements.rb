class CreateProcurements < ActiveRecord::Migration
  def change
    create_table :procurements do |t|
      t.integer :procuring_entity_id
      t.string  :job_number
      t.string  :subject
      t.integer :price
      t.timestamps
    end
  end
end
