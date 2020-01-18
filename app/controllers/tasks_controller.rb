class TasksController < ApplicationController
  before_action :set_group
  before_action :set_tasks

  def index
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      respond_to do |format|
        format.html { redirect_to group_tasks_path(@group), notice: "タスクが作成されました" }
        format.json 
      end
    else
      flash.now[:alert] = "タスクを入力してください。"
      render :index
    end
  end

  private

  def task_params
    params.require(:task).permit(:body, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_tasks
    @tasks = Task.includes(:group).where(user: current_user.id)
  end

end
