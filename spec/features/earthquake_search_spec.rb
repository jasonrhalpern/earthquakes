require 'rails_helper'

feature 'Earthquake Search', :feature do
  given!(:earthquake_one) { create(:earthquake, place: '3km S of Ontario, CA', time_of: '2017-10-11 19:46:32', magnitude: '1.85',
                                  latitude: '34.0235', longitude: '-117.6263333', felt_in_la: true, distance_from_la: '35.17')}
  given!(:earthquake_two) { create(:earthquake, place: '26km N of Gustavus, Alaska', time_of: '2017-10-10 19:36:32', magnitude: '1.78', latitude: '58.6521',
                                 longitude: '-135.7281', felt_in_la: false, distance_from_la: '1880.2')}
  given!(:earthquake_three) { create(:earthquake, place: '4km WNW of The Geysers, California', time_of: '2017-10-11 19:11:21', magnitude: '1.07', latitude: '38.7944984',
                                    longitude: '-122.8001633', felt_in_la: false, distance_from_la: '414.3')}

  scenario 'Search for earthquakes' do
    visit root_path

    fill_in 'start_date', with: '2017-10-08'
    fill_in 'end_date', with: '2017-10-11'
    click_on 'Search'

    expect(page).to have_text earthquake_one.place
    expect(page).to have_text earthquake_one.time_of
    expect(page).to have_text earthquake_one.magnitude
    expect(page).to have_text earthquake_one.distance_from_la

    expect(page).not_to have_text earthquake_two.place
    expect(page).not_to have_text earthquake_two.time_of
    expect(page).not_to have_text earthquake_two.magnitude
    expect(page).not_to have_text earthquake_two.distance_from_la

    expect(page).not_to have_text earthquake_three.place
    expect(page).not_to have_text earthquake_three.time_of
    expect(page).not_to have_text earthquake_three.magnitude
    expect(page).not_to have_text earthquake_three.distance_from_la
  end
end