class RenameUserRoomColumnToEntries < ActiveRecord::Migration[5.2]
  def change
    rename_column :entries, :user, :user_id
    rename_column :entries, :room, :room_id
  end
end
