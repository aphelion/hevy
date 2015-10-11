describe 'Cart Page', type: :feature do
  before :each do
    visit '/cart'
    @content = find('#content')
  end

  after :each do
    clear_cart
  end

  it 'indicates the current page' do
    expect(@content).to have_content('CART')
  end

  describe 'when there are products in the cart' do
    before :each do
      visit '/product/diy-or-die-hoodie'
      find('option', text: 'Small').select_option
      click_on 'ADD TO CART'
    end

    it 'displays a cart form' do
      expect(@content).to have_selector('form[action="/cart"]')
    end

    it 'links from each product back to the product page' do
      click_link 'DIY OR DIE HOODIE'
      expect(URI.parse(current_url).path).to eq '/product/diy-or-die-hoodie'
    end

    it 'shows product options for products with options' do
      expect(@content.find('[name="item-1"] td:nth-child(2)')).to have_content 'Small'
    end

    it 'does not show product options for products without options' do
      visit '/product/script-tote'
      click_on 'ADD TO CART'

      expect(@content.find('[name="item-2"] td:nth-child(2)').text).to eq ''
    end

    it 'displays a button to checkout' do
      click_button 'Checkout'
      expect(URI.parse(current_url).path).to eq '/checkout'
    end

    it 'provides a link back to the products page' do
      expect(@content).to have_link('Continue Shopping')
    end
  end

  describe 'when there are not products in the cart' do
    it 'does not display a cart form' do
      expect(@content).not_to have_selector('form[action="/cart"]')
    end

    it 'displays a message about the empty cart' do
      expect(@content).to have_content('Whoa Doc, this cart is empty.')
    end

    it 'provides a link back to the products page' do
      expect(@content).to have_link('Continue Shopping')
    end
  end

  it 'updates cart quantities' do
    visit '/product/diy-or-die-hoodie'
    find('option', text: 'Small').select_option
    click_on 'ADD TO CART'
    visit '/product/diy-or-die-hoodie'
    find('option', text: 'Medium').select_option
    click_on 'ADD TO CART'

    fill_in('item_1_qty', with: 2)
    click_button('Update Cart')

    within '[name="item-1"]' do
      expect(find_field('item_1_qty').value).to eq '2'
    end
    within '[name="item-2"]' do
      expect(find_field('item_2_qty').value).to eq '1'
    end
  end
end
