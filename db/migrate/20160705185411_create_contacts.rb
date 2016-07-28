class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :phone
      t.string :name
      t.boolean :active
      t.date :birthday
      t.string :address
      t.string :city
      t.string :state
      t.integer :zipcode
      t.timestamps null: false
    end

  end
end
