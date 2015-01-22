class Project < ActiveRecord::Base
  resourcify
  
  has_many :tasks

  validates :team, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :deadline, presence: true

  def complete_all_tasks
    Task.where(project_id: self.id).update_all(is_completed: true)
  end
end
