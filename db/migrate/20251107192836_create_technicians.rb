class CreateTechnicians < ActiveRecord::Migration[7.1]
  def change
    create_table :technicians do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :specializations, null: false, array: true

      t.timestamps
    end

    add_index :technicians, :email, unique: true
  end
end
