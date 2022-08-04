class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.references :role, null: false, default: 0
      t.integer :gender, null: false, default: 0
      t.date :birthday
      t.string :address
      t.string :closest_station
      t.boolean :profile_hide, null: false, default: false
      t.integer :years_of_experience
      t.references :department, null: false, default: 0
      
      t.timestamps
    end
  end
end
