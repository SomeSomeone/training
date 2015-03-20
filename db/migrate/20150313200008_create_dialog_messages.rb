class CreateDialogMessages < ActiveRecord::Migration
  def change
    create_table :dialog_messages do |t|
      t.references :user, index: true
      t.references :dialog, index: true
      t.text :message

      t.timestamps null: false
    end
    add_foreign_key :dialog_messages, :users
    add_foreign_key :dialog_messages, :dialogs
  end
end
