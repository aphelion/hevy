describe 'Product Page', type: :feature do
  describe 'when viewing any product' do
    before :each do
      visit '/product/diy-or-die-hoodie'
      @content = find('#content')
    end

    it 'displays the product title' do
      expect(@content).to have_content 'DIY OR DIE HOODIE'
    end

    it 'displays the product price' do
      expect(@content).to have_content '$49.99'
    end

    it 'displays the primary product image' do
      expect(@content).to have_selector('.product-image-current')
      expect(@content.find('.product-image-current')[:'data-background-image-url']).to be_url
    end

    it 'displays the product description' do
      expect(@content).to have_content('Lorem ipsum dolor sit amet')
    end

    it 'displays thumbnails of all the image options' do
      expect(@content.find('.product-images')).to have_selector('.product-image-selector', count: 2)
    end

    it 'clicking on thumbnails changes the product image' do
      old_image_style = @content.find('.product-image-current')[:style]
      @content.all('.product-images .product-image-selector')[1].click
      expect(@content).not_to have_selector(".product-image-current[style=\"#{old_image_style}\"]")
      [old_image_style, @content.find('.product-image-current')[:style]].each do |style|
        expect(style[/background-image: url\((.+)\)/, 1]).to be_url
      end
    end

    it 'displays facebook like and share buttons' do
      fb_like_share_button = @content.find('.fb-like')
      product_page = page.current_url
      within_frame(fb_like_share_button.find('iframe')) do
        expect(page).to have_content('Like')
        expect(page).to have_content('Share')
        expect(find('input[name="iframe_referer"]', visible: false)[:value]).to eq(product_page)
      end
    end
  end

  describe 'when viewing a product with options' do
    before :each do
      visit '/product/diy-or-die-hoodie'
      @content = find('#content')
    end
    it 'offers the product options in a select element' do
      expect(@content).to have_select('product-options', with_options: ['Small', 'Medium', 'Large', 'X-Large - $59.99'])
    end
  end

  describe 'when viewing a product without options' do
    before :each do
      visit '/product/script-tote'
      @content = find('#content')
    end
    it 'does not show any product options' do
      expect(@content).not_to have_select('product-options')
    end
  end

  describe 'when viewing active products' do
    it 'shows the add to cart form' do
      visit '/product/diy-or-die-hoodie'
      @content = find('#content')
      expect(@content).to have_selector('form[action="/cart"]')
      expect(@content.find('button')).to have_content('ADD TO CART')
    end
  end

  describe 'when viewing sold-out products' do
    it 'does not show the add to cart form' do
      visit '/product/seek-your-fortune-hoodie'
      @content = find('#content')
      expect(@content).not_to have_selector('form[action="/cart"]')
      expect(@content).to have_content('SOLD OUT')
    end
  end

  describe 'when viewing coming-soon products' do
    it 'does not show the add to cart form' do
      visit '/product/script-tee'
      @content = find('#content')
      expect(@content).not_to have_selector('form[action="/cart"]')
      expect(@content).to have_content('COMING SOON')
    end
  end
end
