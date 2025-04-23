class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy ]

  # GET /players or /players.json
  def index
    @players = Player.all
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
    @player.destroy!
    redirect_to players_path, status: :see_other, notice: "Player was successfully destroyed."
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
