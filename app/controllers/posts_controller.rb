class PostsController < ApplicationController
  # 로그인 된 사용자만 접근 가능
  before_action :authenticate_user!, only: [:index, :new, :show, :edit]
  #skip_before_action :authenticate_user!, only: [:index]
  
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :set_bulletin
  
  # 권한설정
  load_and_authorize_resource
  
  # 조회수
  impressionist actions: [:show], unique: [:ip_address]
  
  # # geth 서버 RPC 통신 연동
  # web3 = Web3::Eth::Rpc.new host: '13.209.151.195', 
  #       port: 50796,  
  #       connect_options: { use_ssl: false, read_timeout: 10 }
  web3 = Ethereum::HttpClient.new('http://13.209.151.195:50796')
  
  # Contract
  
  
  # 해시태드
  def hashtags
    tag = Tag.find_by(name: params[:name], bulletin_id: @bulletin.id)
    @posts = tag.posts.order("created_at DESC").page(params[:page]).per(10)
  end
  
  # [Acts_as_Votable] 투표 관련 Controller 내용 : 찬성
  def upvote
    # 만약 '찬성' 투표를 이미 한 경우 : '찬성' 투표 취소
    if ((current_user.voted_up_on? @post) == true)
      @post.unliked_by current_user
      #redirect_to(request.referrer, :notice => '해당 글의 추천을 취소하셨습니다.')
      respond_to do |format|
        format.js { flash[:notice] = "해당 글의 추천을 취소하셨습니다." }
      end
    else
      @post.upvote_by current_user
      #redirect_to(request.referrer, :notice => '해당 글을 추천하셨습니다.')
      respond_to do |format|
        format.js { flash[:notice] = "해당 글을 추천하셨습니다." }
      end
    end
  end
  
  # [Acts_as_Votable] 투표 관련 Controller 내용 : 반대
  def downvote
    # 만약 '반대' 투표를 이미 한 경우 : '반대' 투표 취소
    if ((current_user.voted_down_on? @post) == true)
      @post.unliked_by current_user
      #redirect_to(request.referrer, :notice => '해당 글의 반대를 취소하셨습니다.')
      respond_to do |format|
        format.js { flash[:notice] = "해당 글의 반대를 취소하셨습니다." }
      end
    else
      @post.downvote_from current_user
      #redirect_to(request.referrer, :notice => '해당 글을 반대하셨습니다.')
      respond_to do |format|
        format.js { flash[:notice] = "해당 글을 반대하셨습니다." }
      end
    end
  end

  def index
    @posts = Post.where(bulletin_id: @bulletin).order("created_at DESC").page(params[:page]).per(10)
    if Post.where(bulletin_title: "블록체인 투표")
      @posts = Post.where(bulletin_id: @bulletin).order("created_at DESC").page(params[:page]).per(6)
    end
    @posts_deleted = Post.with_deleted.where(bulletin_id: @bulletin).order("created_at DESC").page(params[:page]).per(10)
  end

  def show
    if current_user.has_role? :admin
      @post = Post.with_deleted.find(params[:id])
    else
      @post = Post.find(params[:id])
    end
    @new_comment  = Comment.build_from(@post, current_user.id, "")
  end

  def new
    @post = @bulletin.present? ? @bulletin.posts.new : Post.new
  end

  def edit
  end

  def create
    @post = @bulletin.present? ? @bulletin.posts.new(post_params) : Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.js
        format.html { redirect_to { (@bulletin.present? ? [@post.bulletin, @post] : @post) } }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to (@bulletin.present? ? [@post.bulletin, @post] : @post), notice: '게시글이 수정되었습니다.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @post.deleted? == true
      @post.really_destroy!
      
      redirect_to bulletin_posts_path(@post.bulletin.id)
    else
      @post.destroy
      
      respond_to do |format|
        format.html { redirect_to bulletin_posts_path(@post.bulletin.id), notice: '게시글이 성공적으로 제거되었습니다.' }
        format.json { head :no_content }
      end
    end
  end
  
  def restore
    @post = Post.with_deleted.find(params[:post_id])
    @post.restore
    
    redirect_to bulletin_posts_path(@post.bulletin.id), notice: '게시글이 성공적으로 복구되었습니다.'
  end

  private
  def set_bulletin
    @bulletin = Bulletin.find(params[:bulletin_id]) if params[:bulletin_id].present?
  end

  def set_post
    if @bulletin.present?
      @post = @bulletin.posts.find(params[:id])
    else
      if current_user.has_role? :admin
        @post = Post.with_deleted.find(params[:id])
      else
        @post = Post.find(params[:id])
      end
    end
  end

  def post_params
    params[:post][:user_id] = current_user.id
    params[:post][:user_nickname] = current_user.nickname
    params.require(:post).permit(:title, :content, :user_id, :user_nickname, :email, :thumb_image, :summary, :opt_agenda1, :opt_agenda2, :opt_agenda3, :opt_agenda4, :opt_agenda5, :opt_agenda6, :opt_agenda7, :opt_agenda8, :opt_agenda9, :opt_agenda10, :price)
  end
end