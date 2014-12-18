class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit]

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def create
  end

  def index
    @projects = Project.all
  end

  private

    def set_project
      @project = params.find(params[:id])
    end

end
