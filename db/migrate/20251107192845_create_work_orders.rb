class CreateWorkOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :work_orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :technician, foreign_key: true
      t.references :status, null: false, foreign_key: { to_table: :statuses }

      t.string :work_type, null: false
      t.text   :description, null: false
      t.string :address, null: false
      t.float  :latitude, null: false
      t.float  :longitude, null: false

      t.timestamps
    end

  end
end
