class ChangeTypeGsmIdentityUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :gsm, :text
    change_column :users, :identity_number, :text
  end
end
