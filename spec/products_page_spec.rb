describe 'Products Page', type: :feature do
  it 'lists all the products' do
    visit '/products'
    content = find('#content')

    expect(content.find('ul')).to have_selector('li', count: 7)
    expect(content).to have_content 'DIY or DIE Hoodie'
  end
end