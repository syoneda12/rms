class CreateLeaderUserLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :leader_user_links do |t|
      t.integer :leader_id
      t.integer :subordinate_id

      t.timestamps
    end
  end
end
