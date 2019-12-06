class AddEmailToStudent < ActiveRecord::Migration
  def change
    change_table :students do |t|
      t.column :email, :string
    end
  end
end
