class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false 
      t.text :in_detail
      t.references :user, null: false, foreign_key: true
      t.datetime :start_time, null: false

      t.timestamps
    end
  end
end
