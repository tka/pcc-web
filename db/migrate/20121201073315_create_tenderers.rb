class CreateTenderers < ActiveRecord::Migration
  def change
    create_table :tenderers do |t|
      t.string :business_number
      t.string :name
      t.timestamps
    end
  end
end
