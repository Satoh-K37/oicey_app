class AddOiceyidNameProfileimageSelfintroductionSexAgeBirthplaceResidenceUserStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :oicey_id, :string, null: false
    add_column :users, :name, :string, null: false
    add_column :users, :profile_image, :string
    add_column :users, :self_introduction, :text 
    add_column :users, :sex, :string, default: 0, null: false
    add_column :users, :age, :integer
    add_column :users, :birthday, :integer 
    add_column :users, :birthplace_id, :integer
    add_column :users, :residence_id, :integer
    add_column :users, :status, :boolean, default: false, null: false
  end
end
