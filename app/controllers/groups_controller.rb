class GroupsController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @groups = current_user.groups.all
  end

  def show;end

  def edit;end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)

    if @group.save
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

  private

  def group_params
    params.require(:group).permit(:name).merge({ user_ids: [current_user.id] })
  end

  def set_article
    @group = current_user.groups.find(params[:id])
  end
end
