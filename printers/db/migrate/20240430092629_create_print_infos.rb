class CreatePrintInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :print_infos do |t|
      t.integer :java_id
      t.string :file_name
      t.string :printer_name
      t.integer :num_copies
      t.string :color
      t.string :orientation
      t.string :status
      t.string :faces
      t.string :user
      t.string :date

      t.timestamps
    end
  end
end
