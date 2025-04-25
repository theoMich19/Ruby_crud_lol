class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy add_player remove_player ]

  # GET /teams or /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1 or /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to team_url(@team), notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    if @team.players.any?
      redirect_to @team, alert: "Impossible de supprimer cette équipe car elle contient des joueurs. Veuillez d'abord retirer tous les joueurs de l'équipe."
    elsif @team.matches.any?
      redirect_to @team, alert: "Impossible de supprimer cette équipe car elle est associée à des matchs. Veuillez d'abord supprimer ou modifier ces matchs."
    else
      @team.destroy
      respond_to do |format|
        format.html { redirect_to teams_url, notice: "L'équipe a été supprimée avec succès." }
        format.json { head :no_content }
      end
    end
  end

  def add_player
    player = Player.find(params[:player_id])
    if player.update(team: @team)
      redirect_to @team, notice: "Le joueur a été ajouté à l'équipe avec succès."
    else
      redirect_to @team, alert: "Impossible d'ajouter le joueur à l'équipe."
    end
  end

  def remove_player
    player = Player.find(params[:player_id])
    if player.update(team: nil)
      redirect_to @team, notice: "Le joueur a été retiré de l'équipe avec succès."
    else
      redirect_to @team, alert: "Impossible de retirer le joueur de l'équipe."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name)
    end
end
