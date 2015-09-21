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
end
