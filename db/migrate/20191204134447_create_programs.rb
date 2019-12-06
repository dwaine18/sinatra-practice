class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :school_name
      t.string :program_name

      t.timestamps null: false
    end
  end
end
