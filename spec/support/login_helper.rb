module LoginHelper
  def login(user)
    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log in"
  end

  def logout
    click_on "Log Out"
  end
end