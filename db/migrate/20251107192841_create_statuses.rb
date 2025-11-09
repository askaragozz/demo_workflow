class CreateStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :statuses do |t|
      t.string :name, null: false
      t.string :type, null: false

      t.timestamps
    end
  end
end
