import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "dateFieldContainer",
    "dateMessage",
    "firstTeam",
    "secondTeam",
  ];

  connect() {
    this.updateDateFieldState();
  }

  updateDateFieldState() {
    const firstTeamId = this.firstTeamTarget.value;
    const secondTeamId = this.secondTeamTarget.value;
    const firstTeamPlayers =
      JSON.parse(this.firstTeamTarget.dataset.players)[firstTeamId] || 0;
    const secondTeamPlayers =
      JSON.parse(this.secondTeamTarget.dataset.players)[secondTeamId] || 0;

    const isValid =
      firstTeamId &&
      secondTeamId &&
      firstTeamId !== secondTeamId &&
      firstTeamPlayers > 0 &&
      secondTeamPlayers > 0;

    if (isValid) {
      this.dateFieldContainerTarget.classList.remove("hidden");
      this.dateMessageTarget.classList.add("hidden");
    } else {
      this.dateFieldContainerTarget.classList.add("hidden");
      this.dateMessageTarget.classList.remove("hidden");
    }
  }
}
