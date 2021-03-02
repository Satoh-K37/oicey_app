class AddAgeBirthdayBirthplaceIdResidenceId < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :integer
    add_column :users, :birthday, :date
    add_column :users, :birthplace_id, :integer, :default => 0
    add_column :users, :residence_id, :integer, :default => 0
  end
end
