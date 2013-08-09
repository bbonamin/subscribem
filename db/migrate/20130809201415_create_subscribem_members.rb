class CreateSubscribemMembers < ActiveRecord::Migration
  def change
    create_table :subscribem_members do |t|
      t.integer :user_id
      t.integer :account_id

      t.timestamps
    end
  end
end
