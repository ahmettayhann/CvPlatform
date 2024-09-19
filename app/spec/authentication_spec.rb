require 'rails_helper'

RSpec.describe "Authentication", type: :system do
  let(:user) { User.create!(email: "user@example.com", password: "password", first_name: "John", last_name: "Doe") }

  it "allows user to log in with correct credentials" do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Log In"

    expect(page).to have_content "Logged in successfully"
    expect(page).to have_content "John Doe"
  end

  it "does not allow user to log in with incorrect credentials" do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "wrong_password"
    click_button "Log In"

    expect(page).to have_content "Invalid email or password"
  end
end