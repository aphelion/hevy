describe 'Products Page', type: :feature do
  before :each do
    visit '/products'
    @content = find('#content')
  end

  it 'lists all 7 products in 3 rows' do
    expect(@content).to have_selector('div.row', count: 3)
    expect(@content).to have_selector('div.row div[class*=col]', count: 7)
    expect(@content).to have_content 'DIY or DIE Hoodie'
  end

  it 'contains an image for each product' do
    @content.all('div.row div.col-md-4').each do |li|
      expect(li).to have_selector('img')
    end
  end

  it 'the image for each product is a valid image' do
    images = @content.all('div.row div.col-md-4 img').map { |img| img[:src] }

    images.each do |link|
      visit link
      expect(page.status_code).to be(200)
    end
  end
end
