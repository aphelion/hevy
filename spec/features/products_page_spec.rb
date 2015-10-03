describe 'Products Page', type: :feature do
  before :each do
    visit '/products'
    @content = find('#content')
  end

  it 'displays all 7 products in 1 rows' do
    expect(@content).to have_selector('div.row', count: 1)
    expect(@content).to have_selector('div.row div[class*=col]', count: 7)
    expect(@content).to have_content 'DIY OR DIE HOODIE'
  end

  it 'displays an image for each product' do
    @content.all('div.row div[class*=col]').each do |product|
      expect(product).to have_selector('div[data-image-url]')
    end
  end

  it 'the image displayed for each product is a valid image' do
    images = @content.all('div.row div[class*=col] div[data-image-url]').map { |div| div[:'data-image-url'] }

    images.each do |src|
      expect(src).to be_url
    end

  end

  it 'links to each product to its product page' do
    @content.all('div.row div[class*=col]').each do |product|
      expect(product).to have_selector('a[href]')
    end
  end
end
