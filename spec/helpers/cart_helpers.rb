module CartHelper
  def clear_cart
    visit '/cart'
    if page.has_button? 'Update Cart'
      all('input[type="text"]').each { |input| input.set(0) }
      click_button('Update Cart')
    end
  end
end
