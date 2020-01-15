class GroupsController < ApplicationController
  before_action :get_group, only: [:index]
  before_action :set_group, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @group = Group.new
  end

  def create
    # @group = Group.new(group_params)
    binding.pry
    if @group.create(group_params)
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
    @group = Group.where("user_id = ?",params[:user_id]).order("id")
  end

  def set_group
    @group = Group.find(params[:id])
  end

end
