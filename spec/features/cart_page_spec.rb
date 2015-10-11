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
    it 'displays a cart form' do
      visit '/product/diy-or-die-hoodie'
      find('option', text: 'Small').select_option
      click_on 'ADD TO CART'

      expect(@content).to have_selector('form[action="/cart"]')
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

  it 'links from each product back to the product page' do
    visit '/product/diy-or-die-hoodie'
    find('option', text: 'Small').select_option
    click_on 'ADD TO CART'
    click_link 'DIY OR DIE HOODIE'
    expect(URI.parse(current_url).path).to eq '/product/diy-or-die-hoodie'
  end
end
