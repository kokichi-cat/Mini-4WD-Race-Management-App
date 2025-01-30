class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :show, :edit, :update ] # ログインユーザーのみ編集可能

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user

    @events = @user.events
                   .left_joins(:race_times) # race_timesがないイベントも取得
                   .select("events.*, COALESCE(MIN(race_times.rap_time), 999999) AS min_rap_time")
                   .group("events.id") # イベント単位でグループ化
                   .order(date: :desc, min_rap_time: :asc) # 日付降順、ラップタイム昇順
                   .page(params[:page]).per(10)
  end


  def edit
    @user = current_user # 自分だけ編集可能
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: "プロフィールを更新しました。"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_picture, :introduction)
  end
end
