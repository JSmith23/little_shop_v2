require 'rails_helper'
describe 'user can create account' do
  it 'user can navigate to create account form' do
    name = "Test Person"
    visit root_path

    click_on "Register"

    expect(current_path).to eq(register_path)

    fill_in :user_name, with: name
    fill_in :user_address, with: "123 alphabet lane"
    fill_in :user_city, with: "Denver"
    fill_in :user_state, with: "CO"
    fill_in :user_zip, with: "80205"
    fill_in :user_email, with: "test@test.com"
    fill_in :user_password, with: "test"
    fill_in :user_password_confirmation, with: "test"


    click_on "Create User"

    expect(current_path).to eq(profile_path(User.last))


    expect(page).to have_content("Logged in as #{name}")
  end
end
