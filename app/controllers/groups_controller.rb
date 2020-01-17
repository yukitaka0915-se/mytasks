class GroupsController < ApplicationController
  include ReminderExists
  before_action :get_group, only: [:index]
  before_action :set_group, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to root_path, notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  def destroy
    if @group.destroy
      redirect_to root_path, notice: 'グループを削除しました'
    else
      render :edit, notice: 'グループが削除できませんでした。'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name).merge(user_id: current_user.id)
  end

  def get_group
    @group = Group.has_with_mytasklist(current_user.id).order("id")
    reminder_exists
  end

  def set_group
    @group = Group.find(params[:id])
  end

end
