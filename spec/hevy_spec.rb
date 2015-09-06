describe 'some basics', :type => :feature do
  it 'provides information' do
    visit '/'
    expect(page).to have_content 'HEVY'
  end
end
