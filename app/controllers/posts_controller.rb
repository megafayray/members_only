class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  #This way doesn't use the Devise helper:
  #before_action :require_login, only: [:new, :create]

  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params) #current_user is a Devise helper that automatically populates the foreign key for the author
    if @post.save
      redirect_to posts_path, notice: "Post created successfully."
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  # def require_login
  #   unless user_signed_in?
  #     redirect_to new_user_session_path
  #   end
  # end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
