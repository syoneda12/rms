class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|
      t.string :name, null: false
      t.references :skill_kind, foreign_key: true
    end
  end
end
