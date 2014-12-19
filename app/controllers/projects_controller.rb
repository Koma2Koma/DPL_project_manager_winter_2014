class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :destroy]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(proj_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def index
    @projects = Project.all
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end

    def proj_params
      params.require(:project).permit(:name)
    end

end
