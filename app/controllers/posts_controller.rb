class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    # @posts = Post.all.includes(:comments)
  end

  # GET /posts/1 or /posts/1.json
  def show
    go(1000)
  end

  # GET /posts/new
  # def new
  #   StackProf.run(mode: :cpu, out: 'tmp/stackprof-cpu-myapp.dump', raw: true) do
  #     @post = Post.new
  #     @post = Post.new

  #     go(300)
  #   end

  #   # stackprof --flamegraph tmp/stackprof-cpu-myapp.dump > tmp/flamegraph  &&
  #   # stackprof --flamegraph-viewer=tmp/flamegraph
  # end

  def new
    Flamegraph.generate('tmp/flamegraph.html') do
      @post = Post.new

      go(300)
    end
  end


  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body, :name, :status)
    end

    def go(n)
      r = 0
      n.times do
        1000.times do
          r = r + 1
        end
      end
      puts "r: #{r}"
    end
end
