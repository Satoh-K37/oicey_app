class AddPlatformNameVoicechatstylePickLegendPlaystyleToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :platform_name, :integer, null: false
    add_column :posts, :voicechatstyle, :integer, null: false
    add_column :posts, :playstyle, :string
    add_column :posts, :picklegend, :string
  end
end
