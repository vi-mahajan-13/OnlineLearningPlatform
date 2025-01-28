class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :age
      t.date :date_of_birth
      t.string :city
      t.string :pincode
      t.string :phone_number

      t.timestamps
    end
  end
end
