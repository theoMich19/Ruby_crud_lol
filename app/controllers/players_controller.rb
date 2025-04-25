class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy ]

  # GET /players or /players.json
  def index
    @players = Player.all
    
    # Filtre par rôle
    if params[:role].present?
      if params[:role] == "none"
        @players = @players.where(role: [nil, ""])
      else
        @players = @players.where(role: params[:role])
      end
    end

    # Filtre par équipe
    if params[:team_id].present?
      if params[:team_id] == "none"
        @players = @players.where(team_id: nil)
      else
        @players = @players.where(team_id: params[:team_id])
      end
    end

    # Recherche par nom/prénom
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @players = @players.where("lower(first_name) LIKE ? OR lower(last_name) LIKE ?", 
                               search_term.downcase, search_term.downcase)
    end
    
    # Pour l'affichage actif dans les filtres
    @selected_role = params[:role]
    @selected_team = params[:team_id]
    @search_term = params[:search]
  end

  # GET /players/1 or /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players or /players.json
  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to @player, notice: "Player was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    # Vérifier si le joueur est dans une équipe qui a un match en cours
    if @player.team.present? && @player.team.matches.in_progress.any?
      @player.errors.add(:base, "L'équipe ne peut pas être modifiée car elle a un match en cours")
      render :edit, status: :unprocessable_entity
      return
    end

    if @player.update(player_params)
      redirect_to @player, notice: "Player was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /players/1 or /players/1.json
  def destroy
    if @player.team.present? && @player.team.matches.any?
      redirect_to @player, alert: "Impossible de supprimer ce joueur car son équipe est associée à des matchs. Veuillez d'abord supprimer ou modifier ces matchs."
    else
      @player.destroy
      respond_to do |format|
        format.html { redirect_to players_url, notice: "Le joueur a été supprimé avec succès." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:last_name, :first_name, :role, :team_id)
    end
end