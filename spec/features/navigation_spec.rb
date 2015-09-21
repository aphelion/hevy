describe 'Site Navigation', type: :feature do
  describe 'the layout' do
    it 'has a navbar' do
      visit '/'
      expect(page).to have_selector '.navbar'
    end
  end

  describe 'the PRODUCTS link' do
    it 'takes the customer to the products page' do
      visit '/'
      find_link('PRODUCTS').click
      expect(find('#content')).to have_content 'PRODUCTS'
      expect(find('#content')).not_to have_content 'HOME'
    end
  end

  describe 'the HOME link' do
    it 'takes the customer to the home page' do
      visit '/'
      find_link('PRODUCTS').click
      find_link('HOME').click
      expect(find('#content')).to have_content 'HOME'
      expect(find('#content')).not_to have_content 'PRODUCTS'
    end
  end
end
