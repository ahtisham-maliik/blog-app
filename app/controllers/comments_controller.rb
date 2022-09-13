class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :show, :destroy]
  before_action :find_commentable
  before_action :set_group, only: [:new, :edit, :create, :update, :destroy, :set_post]
  before_action :set_post, only: [:index, :edit, :new, :create, :update, :destroy]

  def index
    @comments = @post.comments
  end

  def show;end

  def edit
    authorize @comment
  end

  def new
    @comment = @post.comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params.merge({user_id: current_user.id}))

    if @comment.save!
      redirect_to group_post_path(@group, @post), notice: 'Your comment was successfully posted!'
    else
      redirect_to group_post_path(@group, @post), notice: "Your comment wasn't posted!"
    end
  end

  def update
    authorize @comment
    if @comment.update(comment_params)
      flash[:notice] = "Comment was updated successfully"
      redirect_to group_post_path(@group, @post)
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    authorize @comment
    if @comment.destroy
      redirect_to group_posts_path(@group), notice: "Comment was deleted successfully."
    else
      redirect_to group_posts_path(@group), alert: @comment.errors.full_messages.to_sentence
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    if params[:comment_id].present? && params[:post_id].present?
      @commentable = Comment.find_by_id(params[:comment_id])
    else
      @commentable = Post.find_by_id(params[:post_id])
    end
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def set_group
    @group = Group.find_by(id: params[:group_id])
  end

  def set_post
    @post = @group.posts.find_by(id: params[:post_id])
  end
end
