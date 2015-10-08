describe 'add to cart', type: :feature do
  before :each do
    visit '/product/diy-or-die-hoodie'
    @content = find('#content')
  end

  after :each do
    clear_cart
  end

  it 'takes the user to the cart page' do
    click_on 'ADD TO CART'
    expect(@content.find('h1')).to have_content('CART')
  end

  it 'displays the product added to the cart' do
    click_on 'ADD TO CART'
    expect(@content).to have_content 'DIY OR DIE HOODIE'
  end

  it 'adds the selected option to the cart' do
    select('Medium', from: 'cart[add][id]')
    click_on 'ADD TO CART'
    expect(@content).to have_content 'Medium'
  end

  it 'shows the amount of each product / option combination added to the cart' do
    visit '/product/diy-or-die-hoodie'
    find('option', text: 'Medium').select_option
    click_on 'ADD TO CART'

    visit '/product/diy-or-die-hoodie'
    find('option', text: 'X-Large').select_option
    click_on 'ADD TO CART'

    visit '/product/seek-your-fortune-hoodie'
    find('option', text: 'Small').select_option
    click_on 'ADD TO CART'

    visit '/product/diy-or-die-hoodie'
    find('option', text: 'X-Large').select_option
    click_on 'ADD TO CART'

    within '[name="item-1"]' do
      expect(page).to have_content 'DIY OR DIE HOODIE Medium'
      expect(find_field('item_1_qty').value).to eq '1'
    end
    within '[name="item-2"]' do
      expect(page).to have_content 'DIY OR DIE HOODIE X-Large'
      expect(find_field('item_2_qty').value).to eq '2'
    end
    within '[name="item-3"]' do
      expect(page).to have_content 'SEEK YOUR FORTUNE HOODIE Small'
      expect(find_field('item_3_qty').value).to eq '1'
    end

    expect(find('a[href="/cart"]')).to have_content 'CART: 4'
  end
end