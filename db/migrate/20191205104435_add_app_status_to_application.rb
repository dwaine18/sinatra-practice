class AddAppStatusToApplication < ActiveRecord::Migration
  def change
    change_table :applications do |t|
      t.column :app_status, :string,  default:"pending"
    end
  end
end
