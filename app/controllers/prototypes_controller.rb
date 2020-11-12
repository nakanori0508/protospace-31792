class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    # 部分テンプレートにデータを渡す場合、インスタンス変数名は複数形にする。
    # 部分テンプレートにデータを渡したら、部分テンプレ上で使う変数名はインスタンス変数から@を外した単数形にする
    @prototypes = Prototype.all
    # @path = "/prototypes/:prototype_id/users/#{current_user.id}"
  end
  
  def new
    @prototype = Prototype.new
  end

  def create
    # Prototype.create(prototype_params)
    # @prototypeに新規オブジェクトを作成
    @prototype = Prototype.new(prototype_params)
    # prototype_paramsで追加したデータを↓で保存
    if @prototype.save
      # 保存されたらルートパスに戻る
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comments =  Prototype.find(params[:id]).comments.includes(:user)
    @prototype = Prototype.find(params[:id])

  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user_id
      redirect_to action: :index
     end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(user_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id]).destroy
    redirect_to root_path
  end

  private
  def prototype_params
    # prototypeモデルの「タイトル、キャッチコピー、コンセプトカラムの追加を許可
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def user_params
    params.require(:prototype).permit(:title, :catch_copy, :concept)
  end


end
