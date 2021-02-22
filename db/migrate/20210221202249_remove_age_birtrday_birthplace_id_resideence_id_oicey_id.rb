class RemoveAgeBirtrdayBirthplaceIdResideenceIdOiceyId < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :oicey_id, :string
    remove_column :users, :age, :integer
    remove_column :users, :birthday, :integer
    remove_column :users, :birthplace_id, :integer
    remove_column :users, :residence_id, :integer
  end
end
