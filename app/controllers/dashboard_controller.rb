class DashboardController < ApplicationController
  def index
    @recent_matches = Match.order(created_at: :desc).limit(5)
  end
end