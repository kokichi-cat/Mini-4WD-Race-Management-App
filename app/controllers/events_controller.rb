class EventsController < ApplicationController
    # ログインを確認し、未ログインの場合は自動的にログインページへリダイレクトする
    before_action :authenticate_user!, only: %i[new create show edit update destroy]
    before_action :set_event, only: %i[show edit update destroy]
    before_action :authorize_user!, only: %i[edit update destroy]


  # レース記録作成
  def new
    @event = Event.new
    build_associations
  end

  # 全員レース一覧
  def index
    @events = Event.all
    @events = Event.includes(:user, :race_times)
                 .order(date: :desc, event_name: :asc, 'race_times.rap_time': :asc)
  end

  # ログインユーザーだけのレース一覧
  def user_index
    @events = current_user.events.includes(:race_times).order(date: :desc, event_name: :asc, 'race_times.rap_time': :asc) # ログインユーザーのイベントのみ取得
  end



  def show
    @event = Event.find(params[:id])
  end


  def create
    @event = current_user.events.build(event_params)
    Rails.logger.debug @event.inspect # デバッグ用にイベントオブジェクトを表示
    if @event.save
      redirect_to @event, notice: "イベントが作成されました！"
    else
      build_associations # 保存に失敗した場合でも関連データが表示されるように再構築
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: "イベントが更新されました。"
    else
      render :edit
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = "イベントを削除しました。"
      redirect_to events_path
    else
      flash[:alert] = "削除に失敗しました。"
      redirect_to event_path(@event)
    end
  end

  private

  # 必要な関連データを構築
  def build_associations
    @event.race_times.build if @event.race_times.empty?
    machine = @event.machines.build if @event.machines.empty?
    machine.gimmicks.build if machine.gimmicks.empty?
    machine.breakes.build if machine.breakes.empty?
    machine.mass_dampers.build if machine.mass_dampers.empty?
    machine.machine_photos.build if machine.machine_photos.empty?
    @event.course_photos.build if @event.course_photos.empty?
  end

  # ストロングパラメーター
  def event_params
    params.require(:event).permit(
      :date, :event_name, :venue, :weather, :temperature, :coment,
      course_photos_attributes: [ :image ],
      race_times_attributes: [ :id, :rap_time, :course_length, :_destroy ],
      machines_attributes: [
        :id, :machine_name, :frame, :motor, :gear_ratio, :tire_diameter, :tire_type, :voltage, :speed, :other_comments, :body,
        machine_photos_attributes: [ :id, :image, :_destroy ],
        gimmicks_attributes: [
          :id, :gimmick_type,
          rollers_attributes: [ :id, :position, :material, :_destroy ]
        ],
        brakes_attributes: [ :id, :name, :color, :_destroy ],
        mass_dampers_attributes: [ :id, :name, :_destroy ]
      ]
    )
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    unless @event.user == current_user
      flash[:alert] = "編集権限がありません。"
      redirect_to events_path
    end
  end
end
