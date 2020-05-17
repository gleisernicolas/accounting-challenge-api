class CreateAccountEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :account_events do |t|
      t.string :type, null: false
      t.integer :account_id, null: false
      t.text :data, null: false
      t.text :metadata, null: false
      t.datetime :created_at, null: false
  
      t.index :account_id
    end
  end
end
