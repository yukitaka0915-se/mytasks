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
    params.require(:task).permit(
        :title,
        :description,
        :place,
        :completed,
        :priority_id,
        :target_dt,
        :target_tm,
        :warning_st_days,
        :group_id
    ).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
    @groups = Group.find_by(name: params[:user_id])
  end

  def set_tasks
    @tasks = Task.search_all(params[:group_id], current_user.id)
    @tasks_completed = @tasks.search_completed
    @tasks_pending = @tasks.search_pending
    @tasks_warning = @tasks.search_warning
    @tasks_overdue = @tasks.search_overdue
  end

end
