class AddEncryptedColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :gsm_ciphertext, :text
    add_column :users, :identity_number_ciphertext, :text
    remove_column :users, :gsm, :string
    remove_column :users, :identity_number, :string

    add_index :users, :gsm_ciphertext, unique: true, where: "gsm_ciphertext IS NOT NULL"
    add_index :users, :identity_number_ciphertext, unique: true, where: "identity_number_ciphertext IS NOT NULL"
  end
end
