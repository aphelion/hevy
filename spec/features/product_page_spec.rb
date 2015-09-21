describe 'Product Page', type: :feature do
  before :each do
    visit '/product/diy-or-die-hoodie'
    @content = find('#content')
  end

  it 'displays the product title' do
    expect(@content).to have_content 'DIY or DIE Hoodie'
  end

  it 'displays the primary product image' do
    expect(@content).to have_selector('img[src]')
    visit @content.find('img')[:src]
    expect(page.status_code).to be(200)
  end

  it 'displays the product description' do
    expect(@content).to have_content('Lorem ipsum dolor sit amet')
  end

  it 'offers the product options in a select element' do
    expect(@content).to have_select('product-options', with_options: ['Small', 'Medium', 'Large', 'X-Large - $59.99'])
  end
end
