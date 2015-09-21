describe 'a user visiting the site', type: :feature do
    it 'can find and purchase a product' do
      visit '/'
      expect(page).to have_content('HOME')

      click_on 'PRODUCTS'
      expect(page).to have_content('HOME')

      click_on 'DIY or DIE Hoodie'
      expect(page).to have_content('DIY or DIE Hoodie')

      select('Medium', from: 'product-options')
    end
end
