class RemovePlatformNamePlatformIdVoicechatstylePlaystyleFavoriteweaponLegendIdToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :platform_name, :integer
    remove_column :users, :platform_id, :string
    remove_column :users, :voicechatstyle, :integer
    remove_column :users, :playstyle, :string
    remove_column :users, :favoriteweapon, :string
    remove_column :users, :legend_id, :integer
    
  end
end
