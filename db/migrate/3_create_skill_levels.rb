class CreateSkillLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_levels do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
