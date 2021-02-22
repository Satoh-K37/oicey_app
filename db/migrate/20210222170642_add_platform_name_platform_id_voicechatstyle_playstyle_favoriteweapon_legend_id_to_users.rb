class AddPlatformNamePlatformIdVoicechatstylePlaystyleFavoriteweaponLegendIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :platform_name, :integer, null: false
    add_column :users, :platform_id, :string, null: false
    add_column :users, :voicechatstyle, :integer, null: false
    add_column :users, :playstyle, :string
    add_column :users, :favoriteweapon, :string
    add_column :users, :legend_id, :integer
  end
end