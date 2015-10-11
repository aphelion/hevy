describe 'Cart Page', type: :feature do
  before :each do
    visit '/cart'
    @content = find('#content')
  end

  it 'indicates the current page' do
    expect(@content).to have_content('CART')
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

    clear_cart
  end

  it 'links from each product back to the product page' do
    visit '/product/diy-or-die-hoodie'
    find('option', text: 'Small').select_option
    click_on 'ADD TO CART'
    click_link 'DIY OR DIE HOODIE'
    expect(URI.parse(current_url).path).to eq '/product/diy-or-die-hoodie'
  end
end
