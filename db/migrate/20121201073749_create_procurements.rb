class CreateProcurements < ActiveRecord::Migration
  def change
    create_table :procurements do |t|

      t.timestamps
    end
  end
end
