class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :due
      t.string :assigned_to
      t.references :project, index: true


      t.timestamps
    end
  end
end