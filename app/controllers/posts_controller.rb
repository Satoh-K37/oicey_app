class PostsController < ApplicationController
  before_action :set_post, only: [:edit,:update,:destroy]

  def index
    
    # ログインしているユーザーの投稿のみを表示する
    # @posts = current_user.posts.all
    #全ての投稿を表示する 
    @posts = Post.all
    # タグ一覧表示(もっとも使われているタグを10個まで表示する)
    @tags = Post.tag_counts_on(:tags).most_used(10)

    # @post = Post.find(params[:id])
    @post_tags = @posts.tag_counts_on(:tags)
  end

  def show
    @post = Post.find(params[:id])
    # 投稿に紐付くタグの表示
    @mytags = @post.tag_counts_on(:tags)
    # コメントを作成する時に使う
    # @comment = @post.comments.new
    @comment = Comment.new
    # 投稿詳細にされたコメントの一覧を表示させる
    @comments = @post.comments
    
  end

  def new
    # @image = @post.images.build
    @post = Post.new

    # 複数画像
    @post.images.build

  end

  def create
    @post = current_user.posts.new(post_params)
    # 投稿が成功した場合
    if @post.save
      # 画像が添付されているか？
      if params[:url].present?
        # されている場合はフォームに入力されたファイルを1つずつレコードに格納
        params[:url].each do |img|
          @images = @post.images.create!(url: img, post_id: @post.id)
        end
      end
      # 問題がなければ投稿一覧ページに遷移する
      redirect_to posts_url, notice: "投稿を送信しました"
    # 投稿に失敗した場合
    else
      # 新規投稿ページを再度表示する
      render :new
    end

  end

  def edit
    # @post = Post.find(params[:id])
    @post.images.build
  end

  def update
    # @post = Post.find(params[:id])
    # url = すでに投稿されている画像 images_attributes = 新しくInputに追加された画像
    # この二つのどちらかがないときは更新しない
    if params[:post].keys.include?("url") || params[:post].keys.include?("images_attributes")
      # 正しくバリデーションされているか？
      if @post.valid?
        if params[:post].keys.include?("url")
          # DBにある画像がedit画面で一部削除されているかを確認
          update_images_ids = params[:post][:url].values #投稿済み画像 
          before_images_ids = @post.images.ids
          # 
          before_images_ids.each do |before_img_id|
            Image.find(before_img_id).destroy unless update_images_ids.include?("#{before_img_id}") 
          end
        else
          # imageハッシュがない = 投稿済みの画像をすべてedit画面で消しているので、商品に紐づく投稿済み画像を削除する。
          # @product.images.destroy = nil と削除されないので、each do で一つずつ削除する
          before_images_ids.each do |before_img_id|
            Image.find(before_img_id).destroy 
          end
        end
        @post.update(post_params)
        redirect_to posts_url, notice: "投稿を編集しました"
      else
        render :edit, notice: "投稿の編集に失敗しました"
        
      end
    end
    # if @post.update(post_params)
    #   if params[:images].present?
    #     # されている場合はフォームに入力されたファイルを1つずつレコードに格納
    #     params[:images][:url].each do |img|

    #       @images = @post.images.create!(url: img, post_id: @post.id)
    #     end
    #   end
    #   redirect_to posts_url, notice: "投稿を編集しました"
    # else
    #   render :edit
    # end
  end

  def destroy
    
    @post.destroy
    # binding.pry
    redirect_to profile_user_url(@post.user.id), notice: "投稿を削除しました" 
    # redirect_to posts_url, notice: "投稿を削除しました" 
  end


  private

  def set_post
    @post =  current_user.posts.find(params[:id])
  end


  def post_params
    params.require(:post).permit(:body, :visit_day, :tag_list, images_attributes: [:url])
    
      # { images:[] })
    # images_attributes: [:name, :id]).merge(user_id: current_user.id)
  end
end
