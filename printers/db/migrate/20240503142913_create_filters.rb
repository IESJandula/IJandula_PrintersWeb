class CreateFilters < ActiveRecord::Migration[7.1]
  def change
    create_table :filters do |t|
      t.string :printer_name
      t.integer :num_copies
      t.string :color
      t.string :orientation
      t.string :faces
      t.string :user
      t.string :status
      t.string :by

      t.timestamps
    end
  end
end
