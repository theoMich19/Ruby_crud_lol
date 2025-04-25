class ResultsController < ApplicationController
  before_action :set_result, only: %i[ show edit update destroy ]
  before_action :set_match, only: %i[ new create ]

  # GET /results or /results.json
  def index
    @results = Result.includes(match: [:first_team, :second_team])
            .joins(:match)
            .order('matches.date DESC')
  end

  # GET /results/1 or /results/1.json
  def show
    @match = @result.match
  end

  # GET /results/1/edit
  def edit
    @match = @result.match
  end

  # GET /results/new
  def new
    if @match.nil?
      redirect_to matches_path, alert: "Match non trouvé."
      return
    end

    unless @match.in_progress?
      redirect_to @match, alert: "Ce match n'est pas en cours."
      return
    end

    @result = Result.new(match: @match)
  end

  # POST /results or /results.json
  def create
    if @match.nil?
      redirect_to matches_path, alert: "Match non trouvé."
      return
    end

    unless @match.in_progress?
      redirect_to @match, alert: "Ce match n'est pas en cours."
      return
    end

    @result = Result.new(result_params)
    @result.match = @match

    if @result.save
      @match.completed!
      redirect_to @result, notice: "Le résultat a été enregistré avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /results/1 or /results/1.json
  def update
    if @result.update(result_params)
      redirect_to @result, notice: "Le résultat a été mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /results/1 or /results/1.json
  def destroy
    @result.destroy!
    redirect_to results_url, notice: "Le résultat a été supprimé avec succès."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    def set_match
      @match = Match.find(params[:match_id])
    rescue ActiveRecord::RecordNotFound
      @match = nil
    end

    # Only allow a list of trusted parameters through.
    def result_params
      params.require(:result).permit(:first_team_score, :second_team_score)
    end
end
