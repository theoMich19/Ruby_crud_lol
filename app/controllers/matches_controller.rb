class MatchesController < ApplicationController
  before_action :set_match, only: %i[ show edit update destroy start cancel ]

  # GET /matches or /matches.json
  def index
    # Filtrage par statut
    if params[:status].present? && Match.statuses.keys.include?(params[:status])
      @matches = Match.where(status: params[:status])
    else
      @matches = Match.all
    end

    # Tri des matchs du plus récent au plus ancien par date
    @matches = @matches.order(date: :desc)
    
    # Statut actif pour les filtres
    @active_status = params[:status] || "all"
  end

  # GET /matches/1 or /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  def start
    if @match.can_start?
      @match.in_progress!
      redirect_to @match, notice: "Le match a commencé."
    else
      redirect_to @match, alert: "Impossible de démarrer le match."
    end
  end

  def cancel
    if @match.upcoming? || @match.in_progress?
      @match.update!(status: :cancelled)
      redirect_to @match, notice: "Le match a été annulé."
    else
      redirect_to @match, alert: "Impossible d'annuler le match."
    end
  end

  # POST /matches or /matches.json
  def create
    @match = Match.new(match_params)
    @match.status = :upcoming

    if @match.save
      redirect_to @match, notice: "Le match a été créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /matches/1 or /matches/1.json
  def update
    if @match.update(match_params)
      redirect_to @match, notice: "Le match a été modifié avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /matches/1 or /matches/1.json
  def destroy
    @match.destroy!
    redirect_to matches_path, status: :see_other, notice: "Le match a été supprimé avec succès."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def match_params
      params.require(:match).permit(:first_team_id, :second_team_id, :date)
    end
end
