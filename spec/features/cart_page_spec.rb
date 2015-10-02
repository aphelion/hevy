describe 'Cart Page', type: :feature do
  before :each do
    visit '/cart'
    @content = find('#content')
  end

  it 'indicates the current page' do
    expect(@content).to have_content('CART')
  end
end
