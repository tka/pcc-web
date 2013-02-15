class AddTenderInfoCounts < ActiveRecord::Migration
  def up
    add_column :tenderers, :tender_info_count, :integer, :deault => 0
    add_column :tenderers, :winning_tender_info_count, :integer, :deault => 0
    add_index :tenderers, :tender_info_count
    add_index :tenderers, :winning_tender_info_count
    ActiveRecord::Base.connection.execute('update tenderers set tender_info_count = (select count(*) from tender_infos where tender_infos.tenderer_id = tenderers.id)')
    ActiveRecord::Base.connection.execute('update tenderers set winning_tender_info_count = (select count(*) from tender_infos where tender_infos.tenderer_id = tenderers.id and winning = true)')
  end

  def down
    remove_column :tenderers, :tender_info_count
    remove_column :tenderers, :winning_tender_info_count
  end
end
