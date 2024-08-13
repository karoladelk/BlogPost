class BlogPostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
  
    def index
      @blog_posts = Blog.all
    end
  
    def show
        @blog_post = Blog.find(params[:id])
        @comment = Comment.new
      end

    def new
      @blog_post = Blog.new
    end
  
    def create
      @blog_post = current_user.blogs.build(blog_post_params)
      if @blog_post.save
        redirect_to blog_post_path(@blog_post)
      else
        render :new, status: :unprocessable_entity
      end
    end 
  
    def edit
    end
  
    def update
      if @blog_post.update(blog_post_params)
        redirect_to blog_post_path(@blog_post)
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @blog_post.destroy
      redirect_to root_path
    end
  
    private
  
    def blog_post_params
      params.require(:blog).permit(:title, :body)
    end
  
    def set_blog_post
      @blog_post = Blog.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end
  
    def authenticate_user!
      unless current_user
        redirect_to root_path
      end
    end
  
    def authorize_user!
      unless @blog_post.user == current_user
        redirect_to root_path
      end
    end
  end
  