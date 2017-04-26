class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy, :update]

  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(3)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    #@tasks = Task.all.page(params[:page]).per(3)
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(3)

    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render 'toppages/index'
    end
  end

  def edit
  end

  def update

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to root_path
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
      #render root_path
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_back(fallback_location: root_path)
    # redirect_back は、このアクションが実行されたページに戻るメソッドです。例えば、toppages#index で削除ボタンが押されれば、toppages#index に戻します。オプションとして指定した fallback_location: root_path は、戻るべきページがない場合には root_path に戻る仕様です
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  # Strong Parameter
  def task_params
    # p params
    params.require(:task).permit(:content, :status)
    # taskを呼び出し、contentとstatusを許可
    # http://api.rubyonrails.org/classes/ActionController/Parameters.html
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_path
    end
  end
  
end
