class CreateUserSkillLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_skill_links do |t|
      t.references :user, foreign_key: true
      t.references :skill, foreign_key: true
      t.references :skill_level, foreign_key: true
      t.integer :hide, null: false, default: 0
      
      t.timestamps
    end
  end
end
