describe 'Spike Production Test', type: :feature do
  before :each do
    visit '/'
    if page.has_content? 'We’re working on our site at the moment.'
      fail 'website is in maintenance mode'
    end
  end

  it 'loads the homepage' do
    expect(page).to have_selector('#lookbook')
  end
end
