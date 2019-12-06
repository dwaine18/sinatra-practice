class AddPasswordToStudents < ActiveRecord::Migration
  def change
    change_table :students do |t|
    t.column :password_digest, :string
    end

  end
end
