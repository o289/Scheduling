class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :room, null: false, foreign_key: { to_table: :rooms }

      t.timestamps
    end
  end
end
