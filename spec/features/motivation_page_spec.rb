describe 'Motivation Page', type: :feature do
  before :each do
    visit '/contact'
    @content = find('#motivation')
  end

  it 'displays motivation' do
    expect(@content).to have_content('Rebel and Endure.')
  end
end
