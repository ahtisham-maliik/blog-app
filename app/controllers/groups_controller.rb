class GroupsController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @groups = current_user.groups.all
  end

  def show
  end

  def edit
  end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)

    if @group.save
      flash[:notice] = "Group has been created successfully."
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "Group was updated"
      redirect_to group_path(@group)
    else
      flash[:notice] = "Group was not updated"
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    flash[:notice] = "Group has been deleted successfully."
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:name).merge({ user_ids: [current_user.id] })
  end

  private
  def set_article
    @group = current_user.groups.find(params[:id])
  end
end
