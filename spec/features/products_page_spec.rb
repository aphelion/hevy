describe 'Products Page', type: :feature do
  before :each do
    visit '/products'
    @content = find('#content')
  end

  it 'displays all 7 products in 1 row' do
    expect(@content).to have_selector('div.row', count: 1)
    expect(@content).to have_selector('div.row div[class*=col]', count: 7)
  end

  it 'displays name and price for products' do
    expect(@content).to have_content 'DIY OR DIE HOODIE $49.99'
  end

  it 'displays the primary image and contains a hidden secondary image for each product' do
    primary_images = @content.all('.product .product-image-primary[data-background-image-url]', visible: :all).map { |div| div[:'data-background-image-url'] }
    secondary_images = @content.all('.product .product-image-secondary[data-background-image-url]', visible: :all).map { |div| div[:'data-background-image-url'] }

    expect(primary_images.length).to eq 7
    expect(secondary_images.length).to eq 6

    primary_images.each do |image_url|
      expect(image_url).to be_url
      expect(secondary_images).not_to include image_url
    end

    secondary_images.each do |image_url|
      expect(image_url).to be_url
      expect(primary_images).not_to include image_url
    end
  end

  it 'shows the secondary image only when hovering on a product' do
    products_with_two_images = @content.all('.product .product-image-secondary', visible: :all)
                                   .map { |secondary| secondary.find(:xpath, '..') }
    expect(products_with_two_images.length).to eq 6

    products_with_two_images.each do |product|
      expect(product).to have_selector('.product-image-primary', visible: true)
      expect(product).to have_selector('.product-image-secondary', visible: false)
    end

    products_with_two_images.each do |product|
      product.hover
      expect(product).to have_selector('.product-image-secondary', visible: true)
    end
  end

  it 'links to each product to its product page' do
    @content.all('div.row div[class*=col]').each do |product|
      expect(product).to have_selector('a[href]')
    end
  end
end
