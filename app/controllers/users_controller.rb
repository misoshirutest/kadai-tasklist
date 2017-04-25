# インスタンス変数の単数形と複数形に注意

class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    # @tasks = @user.tasks.order('created_at DESC').page(params[:page])
    # counts @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
      # 処理を users#show のアクションへと強制的に移動させるもので、create アクション実行後に更に show アクションが実行され、show.html.erb が呼ばれます
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
