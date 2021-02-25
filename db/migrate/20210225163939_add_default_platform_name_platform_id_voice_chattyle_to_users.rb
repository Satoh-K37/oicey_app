class AddDefaultPlatformNamePlatformIdVoiceChattyleToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :platform_name, :integer, :default => 0
    change_column :users, :platform_id, :string, :default => ''
    change_column :users, :voicechatstyle, :integer, :default => 0
  end
end
