class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :student_id
      t.integer :program_id

      t.timestamps null: false
    end
  end
end
