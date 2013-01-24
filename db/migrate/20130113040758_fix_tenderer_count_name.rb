class FixTendererCountName < ActiveRecord::Migration
  def up
    rename_column :tenderers, :winning_tender_info_count, :winning_tender_infos_count
    rename_column :tenderers, :tender_info_count, :tender_infos_count
  end

  def down
    rename_column :tenderers, :winning_tender_infos_count, :winning_tender_info_count
    rename_column :tenderers, :tender_infos_count, :tender_info_count
  end
end
