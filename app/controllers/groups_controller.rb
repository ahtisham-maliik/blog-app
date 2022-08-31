class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :show, :destroy, :leave_group, :join_group]

  def index
    @groups = Group.all
  end

  def show;end

  def edit;end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.build(group_params)

    if @group.save
      @group.user_groups.create(user_id: current_user.id)
      redirect_to groups_path, notice: "Group was created successfully."
    else
      flash[:alert] = @group.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "Group was updated successfully"
      redirect_to group_path(@group)
    else
      flash[:alert] = @group.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    if @group.destroy
      redirect_to groups_path, notice: "Group was deleted successfully."
    else
      redirect_to groups_path, alert: @group.errors.full_messages.to_sentence
    end
  end

  def join_group
    @group.user_groups.create(user_id: current_user.id)
    redirect_to groups_index_path, notice: "Group joined successfully."
  end

  def leave_group
    @group.user_groups.find_by(user_id: params[:user_id]).destroy
    redirect_to groups_index_path, notice: "Group left successfully."
  end

  private

  def group_params
    params.require(:group).permit(:name).merge({ creator_id: current_user.id })
  end

  def set_group
    @group = Group.find_by(id: params[:id])
  end
end
