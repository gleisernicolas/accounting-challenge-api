class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.integer :balance, null: false
      t.string :number, null: false, unique: true
      t.text :token, null: false, unique: true

      t.timestamps
    end
  end
end
