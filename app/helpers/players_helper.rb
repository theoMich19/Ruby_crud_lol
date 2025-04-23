module PlayersHelper
  def team_options_for_select
    Team.all.map do |team|
      [team.full? ? "#{team.name} (Équipe complète)" : team.name, team.id, { disabled: team.full? }]
    end
  end
end
