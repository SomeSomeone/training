class CreateAdapters < ActiveRecord::Migration
  def change
    create_table :adapters do |t|
      t.references :user, index: true
      t.references :dialog, index: true

      t.timestamps null: false
    end
    add_foreign_key :adapters, :users
    add_foreign_key :adapters, :dialogs
  end
end
