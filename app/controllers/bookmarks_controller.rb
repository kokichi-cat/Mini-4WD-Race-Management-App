class BookmarksController < ApplicationController
    before_action :authenticate_user!

    def create
        @event = Event.find(params[:event_id])
        current_user.bookmarks.create(event: @event)
        redirect_to @event, notice: "ブックマークしました"
    end

    def destroy
        @event = Event.find(params[:event_id])
        current_user.bookmarks.find_by(event: @event)&.destroy
        redirect_to @event, notice: "ブックマークを解除しました"
    end

    def index
        @events = current_user.bookmarked_events.includes(:user, :race_times)
    end
end
