class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    # retrieve all posts created by me
    sql = "user_id = #{current_user.id}"

    # retrieve all posts created by my friends
    friend_ids = current_user.friends.ids
    friend_ids_string = friend_ids.join(", ")
    if (friend_ids_string.length > 0)
      sql = sql + " or user_id in (#{friend_ids_string})"
    end

    @posts = Post.where("#{sql}").order(:created_at)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    current_user.posts << @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def invite
    @userToInvite = User.find_by(:email => params['email'])
    @invitations = current_user.invitations
    if (@userToInvite != nil)
      current_user.friend_relationships.create(:friend => @userToInvite)
      @userToInvite.friend_relationships.create(:friend => current_user)
    else
      @userToInvite = User.invite!({:email => params['email'], :skip_invitation => true}, current_user)
    end
    @userToInvite
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:post_text)
    end
end
