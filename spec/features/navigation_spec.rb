describe 'Site Navigation', type: :feature do
  before :each do
    visit '/'
    @content = find('#content')
  end

  describe 'the layout' do
    it 'has a navbar' do
      expect(page).to have_selector '.navbar'
    end
  end

  describe 'the PRODUCTS link' do
    it 'takes the customer to the products page' do
      click_link('PRODUCTS')
      expect(@content).to have_content 'PRODUCTS'
      expect(@content).not_to have_content 'HOME'
    end
  end

  describe 'the cart link' do
    it 'takes the customer to the cart page' do
      find('a[href="/cart"]').click
      expect(@content).to have_content 'CART'
      expect(@content).not_to have_content 'HOME'
    end
  end

  describe 'the HOME link' do
    it 'takes the customer to the home page' do
      click_link('PRODUCTS')
      find_link('HOME').click
      expect(@content).to have_content 'HOME'
      expect(@content).not_to have_content 'PRODUCTS'
    end
  end
end
