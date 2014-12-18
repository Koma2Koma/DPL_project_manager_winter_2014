class TasksController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :new, :create, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = @project.tasks.build
  end

  def create
    @task = @project.tasks.build(task_params)
    if @task.save
      redirect_to project_task_path(@project, @task)
    else
      render :new
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      redirect_to project_task_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to project_path(@project)
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def task_params
       params.require(:task).permit(:title, :description, :due, :assigned_to)
    end
end
