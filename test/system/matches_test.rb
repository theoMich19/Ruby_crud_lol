require "application_system_test_case"

class MatchesTest < ApplicationSystemTestCase
  setup do
    @match = matches(:one)
  end

  test "visiting the index" do
    visit matches_url
    assert_selector "h1", text: "Matches"
  end

  test "should create match" do
    visit matches_url
    click_on "New match"

    fill_in "Date", with: @match.date
    fill_in "First team", with: @match.first_team_id
    fill_in "Second team", with: @match.second_team_id
    fill_in "Status", with: @match.status
    click_on "Create Match"

    assert_text "Match was successfully created"
    click_on "Back"
  end

  test "should update Match" do
    visit match_url(@match)
    click_on "Edit this match", match: :first

    fill_in "Date", with: @match.date
    fill_in "First team", with: @match.first_team_id
    fill_in "Second team", with: @match.second_team_id
    fill_in "Status", with: @match.status
    click_on "Update Match"

    assert_text "Match was successfully updated"
    click_on "Back"
  end

  test "should destroy Match" do
    visit match_url(@match)
    accept_confirm { click_on "Destroy this match", match: :first }

    assert_text "Match was successfully destroyed"
  end
end
