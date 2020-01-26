class TasksController < ApplicationController
  before_action :get_group, :get_tasks, only: [:index]

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
    # binding.pry
    # warning_dt = ""
    # target_dt = params[:task][:target_dt]
    # warning_st_days = params[:task][:warning_st_days]
    # binding.pry
    # if target_dt.length > 0
    #   date_ary = target_dt.split("-")
    #   if Date.valid_date?(date_ary[0].to_i, date_ary[1].to_i, date_ary[2].to_i)
    #     warning_st_days = 0 if warning_st_days.length == 0
    #     warning_dt = target_dt - warning_st_days 
    #   end
    # end
    # completed = params[:task][:completed].to_i
    # completed_at = Time.now if completed == 1
    # binding.pry
    # params.require(:task).permit(
    #   :title,
    #   :description,
    #   :place,
    #   :completed,
    #   :priority_id,
    #   :target_dt,
    #   :target_tm,
    #   :warning_st_days,
    #   :group_id
    # ).merge(
    #   warning_dt: warning_dt,
    #   completed_at: completed_at,
    #   user_id: current_user.id
    # )
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
    ).merge(
      user_id: current_user.id
    )
    binding.pry
  end

  def get_group
    @group = Group.find(params[:group_id])
    @groups = current_user.groups
  end

  def get_tasks
    @tasks = Task.search_all(current_user.id, params[:group_id])
    @tasks_completed = @tasks.search_completed
    @tasks_pending = @tasks.search_pending
    @tasks_warning = @tasks.search_warning
    @tasks_overdue = @tasks.search_overdue
  end

end
