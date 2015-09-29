describe 'Home Page', type: :feature do
  before :each do
    visit '/'
    @content = find('#content')
  end

  it 'displays a lookbook' do
    expect(@content).to have_selector('#lookbook-container #lookbook')
  end
end
