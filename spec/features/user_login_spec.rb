require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  before :each do
    @user = User.create!(
      name: 'test_name',
      email: 'test@email.com',
      password: '123456',
      password_confirmation: '123456'
    )
  end

  scenario "A user can login" do
    # ACT
    visit root_path
    click_link 'Login'
    fill_in 'email', with: 'test@email.com'
    fill_in 'password', with: '123456'
    click_button 'Submit'
       
    # VERIFY
    expect(page).to have_content 'Logout'
  end

end
