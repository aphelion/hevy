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

  describe 'the related sites icon links' do
    it 'Aphelion icon goes to the Aphelion homepage' do
      click_link_expect_new_window_with_url('.icon-hex-aphelion', 'aphelion.io')
    end

    it 'Instagram icon goes to the Instagram page' do
      click_link_expect_new_window_with_url('.icon-hex-instagram', 'instagram.com')
    end

    it 'Facebook icon goes to the Facebook page' do
      click_link_expect_new_window_with_url('.icon-hex-facebook', 'facebook.com')
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
      expect(@content).to have_selector '#lookbook'
      expect(@content).not_to have_content 'PRODUCTS'
    end
  end
end

def click_link_expect_new_window_with_url(link_selector, url_include)
  new_window = window_opened_by { find(link_selector).click }
  begin
    within_window new_window do
      expect(current_url).to include(url_include)
    end
  ensure
    new_window.close
  end
end
