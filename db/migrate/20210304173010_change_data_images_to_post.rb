class ChangeDataImagesToPost < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :images, :json
  end
end
