class DashboardController < ApplicationController
  def index
    @recent_matches = Match.order(created_at: :desc).limit(5)
    @upcoming_matches = Match.upcoming.order(date: :asc).limit(4)
  end
end