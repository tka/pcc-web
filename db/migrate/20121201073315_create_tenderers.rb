class CreateTenderers < ActiveRecord::Migration
  def change
    create_table :tenderers do |t|

      t.timestamps
    end
  end
end
