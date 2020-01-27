class TasksController < ApplicationController
  before_action :get_group, :get_tasks, except: [:show]
  before_action :set_task, only: [:edit, :update, :destroy]

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

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: "タスクが更新されました。"
    else
      flash.now[:alert] = "タスクを入力してください。"
      render :index
    end
  end

  private

  def task_params
    params.require(:task).permit(
      :id,
      :title,
      :description,
      :place,
      :completed,
      :priority_id,
      :target_dt,
      :target_tm,
      :warning_st_days,
      :group_id
    ).merge(
      user_id: current_user.id
    )
  end

  def get_group
    @groups = current_user.groups
    @group = @groups.find(params[:group_id])
  end

  def get_tasks
    @tasks = @group.tasks.includes(:user)
    @tasks_completed = @tasks.search_completed
    @tasks_pending = @tasks.search_pending
    @tasks_warning = @tasks.search_warning
    @tasks_overdue = @tasks.search_overdue
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
