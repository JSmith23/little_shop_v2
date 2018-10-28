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

  it 'user can login via form' do
    user = User.create!(name: "Test Person", address: "123 lane", city: "Denver", state: "CO", zip: "80205", email: "test@test.com", password: "12345", password_confirmation: "12345")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: "test@test.com"
    fill_in :password, with: "12345"

    click_on "Log in"


    expect(current_path).to eq(profile_path(user))
  end

  it 'user cannot login via form with invalid information' do
    user = User.create!(name: "Test Person", address: "123 lane", city: "Denver", state: "CO", zip: "80205", email: "test@test.com", password: "12345", password_confirmation: "12345")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: "test@test.com"
    fill_in :password, with: "1234"

    click_on "Log in"

    expect(current_path).to eq(sessions_path)
  end

  it 'user can logout while they are logged in' do
    user = User.create!(name: "Test Person", address: "123 lane", city: "Denver", state: "CO", zip: "80205", email: "test@test.com", password: "12345", password_confirmation: "12345")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: "test@test.com"
    fill_in :password, with: "12345"

    click_on "Log in"


    expect(current_path).to eq(profile_path(user))

    click_on "Log Out"

    expect(current_path).to eq(root_path)
  end

  it 'logged in user visiting login page is redirected to profile' do
      
    user = User.create!(name: "Test Person", address: "123 lane", city: "Denver", state: "CO", zip: "80205", email: "test@test.com", password: "12345", password_confirmation: "12345")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: "test@test.com"
    fill_in :password, with: "12345"

    click_on "Log in"

    expect(page).to have_content("Logged in as #{user.name}")

    visit login_path

    expect(current_path).to eq(profile_path)
  end
end
