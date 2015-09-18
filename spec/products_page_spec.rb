describe 'Products Page', type: :feature do
  before :each do
    visit '/products'
    @content = find('#content')
  end

  it 'lists all the products' do
    expect(@content.find('ul')).to have_selector('li', count: 7)
    expect(@content).to have_content 'DIY or DIE Hoodie'
  end

  it 'contains an image for each product' do
    @content.all('ul li').each do |li|
      expect(li).to have_selector('img')
    end
  end

  it 'contains a valid image for each product' do
    images = @content.all('ul li img').map { |img| img[:src] }

    images.each do |link|
      visit link
      expect(page.status_code).to be(200)
    end
  end
end
