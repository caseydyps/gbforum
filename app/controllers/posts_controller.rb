class PostsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  before_action :set_post, only: [:edit, :show, :update, :destroy]
  before_action :auth_user, only: [:edit, :update, :destroy]
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

  end

  def create
    @post = Post.new(post_params)
     @post.user = current_user
    if @post.save
      flash[:notice] = "Create successfully"
      redirect_to session.delete(:return_to)
    else
      flash.now[:alert] = "Create failed"
      render :new
    end
  end

  def update

    if @post.update(post_params)
      flash[:notice] = "Update successfully"
      redirect_to session.delete(:return_to)
    else
      flash.now[:alert] = "Update failed"
      render :edit
    end
  end

  def destroy

    if @post.destroy
      flash[:notice] = "Delete successfully"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = "Delete failed"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, category_ids: [])
  end

   def set_post
    @post = Post.find(params[:id])
  end

  def auth_user
    @user = @post.user
    if @user != current_user
      redirect_back fallback_location: root_path, alert: "No right！"
    end
  end

end
