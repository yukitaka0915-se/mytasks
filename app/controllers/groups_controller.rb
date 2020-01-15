class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @group = Group.new
    @group.users << current_user
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
      redirect_to group_path(@group), notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  def destroy
    if @group.destroy
      redirect_to group_path(@group), notice: 'グループを更新しました'
      render :index
    else
      render :edit
    end
    if @group.destroy
      notice = 'グループを削除しました'
    else
      notice = 'グループが削除できませんでした。'
    end
    redirect_to root_path, notice: notice
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def set_group
    @group = Group.find(params[:id])
  end

end
