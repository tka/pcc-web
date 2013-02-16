class CreateTenderInfos < ActiveRecord::Migration
  def change
    create_table :tender_infos do |t|
      t.references :procurement
      t.references :tenderer
      t.integer :price, :limit => 8
      t.boolean :winning, :default => false
      t.timestamps
    end
    add_index :tender_infos, :procurement_id
    add_index :tender_infos, :tenderer_id
  end
end
