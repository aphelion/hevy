describe 'Maintenance Mode', type: :feature do
  it 'loads a Hevy branded maintenance page' do
    visit '/maintenance'
    expect(page).to have_content("We're working on our site at the moment. Please check back soon.")
    expect(page).to have_selector('#footer')
  end
end
