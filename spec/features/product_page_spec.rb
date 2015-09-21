describe 'Product Page', type: :feature do
  before :each do
    visit '/product/diy-or-die-hoodie'
    @content = find('#content')
  end

  it 'contains the product title' do
    expect(@content).to have_content 'DIY or DIE Hoodie'
  end
end
