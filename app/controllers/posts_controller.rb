class PostsController < ApplicationController
  before_action :set_group
  before_action :set_post, only: [:create, :edit, :show, :update, :destroy]

  def index
    @posts = @group.posts
  end

  def show;end

  def edit;end

  def new
    @post = @group.posts.new
  end

  def create
    @post = @group.posts.new(post_params)

    if @post.save
      redirect_to group_path(@group), notice: "Post was created successfully."
    else
      redirect_to group_path(@group), alert: @post.errors.full_messages.to_sentence
    end
  end

  def update
    if @post.update(post_params)
      redirect_to group_path(@group), notice: "Post was updated successfully"
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      redirect_to group_posts_path(@group), notice: "Post was deleted successfully."
    else
      redirect_to group_posts_path(@group), alert: @post.errors.full_messages.to_sentence
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :group_id, :image).merge({user_id: current_user.id, group_id: @group.id})
  end

  def set_group
    @group = Group.find_by(id: params[:group_id])
  end

  def set_post
    @post = @group.posts.find_by(id: params[:id])
  end
end
