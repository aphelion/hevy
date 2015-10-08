module CartHelper
  def clear_cart
    visit '/cart'
    all('input[type="text"]').each { |input| input.set(0) }
    click_button('Update Cart')
  end
end