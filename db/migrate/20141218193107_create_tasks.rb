class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.boolean :is_completed
      t.references :project, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
