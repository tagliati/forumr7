class PostsController < ApplicationController
  def index
    limit = 10
    @post = Post.new
    @posts = Post.limit(limit).offset((limit *params[:i].to_i)).where(:parent_id => nil)
    @total_pages = (Post.where(:parent_id => nil).count/limit).ceil
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @post }
    end
  end

  def show
    @post = Post.find(params[:id])
    @posts_loaded = 0
    @total_posts = 0
    @start = 10*params[:i].to_i
    @final = @start+10
    @path = Array.new
    @counter = 1
  end

  def create
    root_parent_id = params[:post][:root_parent_id]
    params[:post].delete :root_parent_id
    @post = Post.new(params[:post])
    @post.comment = Blacklist.validate_comment(@post.comment)
    respond_to do |format|
      redirect_path = root_path
      unless @post.parent_id.nil?
        redirect_path = "#{root_url()}#{root_parent_id}"
      end
      if @post.save

        format.html  { redirect_to(redirect_path) }
        format.json  { render :json => @post,
                      :status => :created, :location => @post }
      else
        format.html  { redirect_to(redirect_path, :error => "not blank")  }
        format.json  { render :json => @post.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

end
