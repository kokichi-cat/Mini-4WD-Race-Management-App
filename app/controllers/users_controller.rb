class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update] # ログインユーザーのみ編集可能

  def show
    if params[:id] # 他人のページを見ようとしている場合
      @user = User.find(params[:id])
    else # 自分のマイページを開こうとしている場合
      @user = current_user
    end
    @events = @user.events # ユーザーが持つイベントを取得
  end

  def edit
    @user = current_user # 自分だけ編集可能
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: 'プロフィールを更新しました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_picture, :introduction)
  end
end
