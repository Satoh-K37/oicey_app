class RemoveImagesToPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :images, :string
  end
end
