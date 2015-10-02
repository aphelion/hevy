describe 'About Page', type: :feature do
  before :each do
    visit '/contact'
    @content = find('#content')
  end

  it 'displays information about Hevy' do
    expect(@content).to have_content('ABOUT')
  end

  it 'displays contact information' do
    expect(@content).to have_content('CONTACT')
  end
end
