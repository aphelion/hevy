describe 'Product meta tags', type: :feature do
  it 'has only the site_name open graph meta tag on the homepage' do
    visit '/'

    expect(page).not_to have_selector 'meta[property="og:title"]', visible: false
    expect(page).not_to have_selector 'meta[property="og:type"]', visible: false
    expect(page).not_to have_selector 'meta[property="og:url"]', visible: false
    expect(page).not_to have_selector 'meta[property="og:image"]', visible: false
    expect(page.find('meta[property="og:site_name"]', visible: false)[:content]).to eq(page.title)
  end

  it 'has several open graph meta tag on product pages' do
    visit '/product/diy-or-die-hoodie'

    expect(page.find('meta[property="og:title"]', visible: false)[:content]).to eq('DIY or DIE Hoodie')
    expect(page.find('meta[property="og:type"]', visible: false)[:content]).to eq('product.item')
    expect(page.find('meta[property="og:url"]', visible: false)[:content]).to eq(page.current_url)
    expect(page.find('meta[property="og:image"]', visible: false)[:content]).to be_url
    expect(page.find('meta[property="og:site_name"]', visible: false)[:content]).to eq(page.title)
  end
end
