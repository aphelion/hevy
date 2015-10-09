require 'uri'

describe 'Product Page', type: :feature do
  describe 'when viewing any product' do
    before :each do
      visit '/product/diy-or-die-hoodie'
      @content = find('#content')
    end

    it 'displays the product title' do
      expect(@content).to have_content 'DIY OR DIE HOODIE'
    end

    it 'displays the primary product image' do
      expect(@content).to have_selector('.product-image')
      expect(@content.find('.product-image')[:'data-background-image-url']).to be_url
    end

    it 'displays the product description' do
      expect(@content).to have_content('Lorem ipsum dolor sit amet')
    end

    it 'offers the product options in a select element' do
      expect(@content).to have_select('product-options', with_options: ['Small', 'Medium', 'Large', 'X-Large - $59.99'])
    end

    it 'displays thumbnails of all the image options' do
      expect(@content.find('.product-images')).to have_selector('.product-image-option', count: 2)
    end

    it 'clicking on thumbnails changes the product image' do
      old_image_style = @content.find('.product-image')[:style]
      @content.all('.product-images .product-image-option')[1].click
      new_image_style = @content.find('.product-image')[:style]
      expect(new_image_style).not_to eq old_image_style
      [old_image_style, new_image_style].each do |style|
        expect(style[/background-image: url\((.+)\)/, 1]).to be_url
      end
    end

    it 'displays a facebook share button' do
      fb_share_button = @content.find('.fb-share-button')
      product_page = page.current_url
      within_frame(fb_share_button.find('iframe')) do
        share_link = URI.unescape(find_link('Share')[:href])
        expect(share_link).to have_content(product_page)
      end
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
      expect(@content).to have_content('Sold Out')
    end
  end

  describe 'when viewing coming-soon products' do
    it 'does not show the add to cart form' do
      visit '/product/script-tee'
      @content = find('#content')
      expect(@content).not_to have_selector('form[action="/cart"]')
      expect(@content).to have_content('Coming Soon')
    end
  end
end
