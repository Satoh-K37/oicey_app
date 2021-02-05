class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer :user
      t.integer :room
      t.timestamps
    end
  end
end
