class ChangeStatusToAvailable < ActiveRecord::Migration[6.0]
  def change
    rename_column :drivers, :status, :available
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
