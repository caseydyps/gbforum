class PostsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @posts=Post.all
  end

  def new
    @post=Post.new
  end

  def edit
    if current_user == @post.user
      # allow to edit

    else
      redirect_to post_path(@post.id)
    end
  end

  def show
    @post=Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Create successfully"
      redirect_to session.delete(:return_to)
    else
      flash.now[:alert] = "Create failed"
      render :new
    end
  end

  def update
    @post=Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Update successfully"
      redirect_to session.delete(:return_to)
    else
      flash.now[:alert] = "Update failed"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Delete successfully"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = "Delete failed"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end

end
