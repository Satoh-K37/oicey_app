class RemovePlatformNameVoicechatstylePlaystylePicklegendToPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :platform_name, :integer
    remove_column :posts, :voicechatstyle, :integer
    remove_column :posts, :playstyle, :string
    remove_column :posts, :picklegend, :string
  end
end
