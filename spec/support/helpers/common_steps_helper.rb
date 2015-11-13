module CommonStepsHelper
 ## Helpers
  def sign_up_user_one
    visit '/'
    click_link 'Sign up'
    fill_in 'user[email]', with: 'steve@test.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Sign up'
  end

  def sign_up_user_two
    visit '/'
    click_link 'Sign up'
    fill_in 'user[email]', with: 'joe@test.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Sign up'
  end

  def sign_up_user_three
    visit '/'
    click_link 'Sign up'
    fill_in 'user[email]', with: 'barry@test.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Sign up'
  end

  def create_listing_one
    visit '/listings/new'
    fill_in 'listing[title]', with: '1959 Les Paul'
    fill_in 'listing[subtitle]', with: 'A true gem with OHSC'
    fill_in 'listing[description]', with: 'Test description'
    click_button 'Create Listing'
  end

  def create_listing_two
    visit '/listings/new'
    fill_in 'listing[title]', with: '1970 CBS Strat'
    fill_in 'listing[subtitle]', with: 'Olympic White'
    fill_in 'listing[description]', with: 'Test description'
    click_button 'Create Listing'
  end

  def create_listing_three
    visit '/listings/new'
    fill_in 'listing[title]', with: 'Takamine'
    fill_in 'listing[subtitle]', with: 'MIJ'
    fill_in 'listing[description]', with: 'Test description'
    click_button 'Create Listing'
  end

  def add_listing_one_to_watchlist
    visit listings_path
    click_link '1959 Les Paul'
    click_link 'Add to my watchlist - 1959 Les Paul'
  end

  def add_listing_two_to_watchlist
    visit listings_path
    click_link '1970 CBS Strat'
    click_link 'Add to my watchlist - 1970 CBS Strat'
  end

  def sign_out
    visit root_path
    click_link 'Sign out'
  end

  def sign_in(user)
    visit root_path
    click_link 'Sign in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  def add_listing_to_watchlist(listing)
    visit listings_path
    click_link(listing.title)
    click_link('Add to my watchlist - "#{listing.title}"')
  end



end