require 'spec_helper'

feature 'Accounts' do
  scenario 'creating an account' do
    visit subscribem.root_path
    click_link 'Account Sign Up'

    fill_in 'Name', with: 'Test'
    fill_in 'Subdomain', with: 'test'
    fill_in 'Email', with: 'subscribem@example.com'
    password_field_id = 'account_owner_attributes_password'
    fill_in password_field_id, with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Create Account'
    success_message = 'Your account has been successfully created.'
    expect(page).to have_content(success_message)
    expect(page).to have_content('Signed in as subscribem@example.com')
    expect(page.current_url).to eq('http://test.example.com/')
  end

  scenario "Ensure subdomain uniqueness" do
    Subscribem::Account.create!(:subdomain => "test", :name => "Test")
    visit subscribem.root_path
    click_link 'Account Sign Up'
    fill_in 'Name', :with => "Test"
    fill_in 'Subdomain', :with => "test"
    fill_in 'Email', :with => "subscribem@example.com"
    fill_in 'Password', :with => "password"
    fill_in 'Password confirmation', :with => "password"
    click_button "Create Account"
    expect(page.current_url).to eq("http://www.example.com/accounts")
    expect(page).to have_content("Sorry, your account could not be created.")
    expect(page).to have_content("Subdomain has already been taken")
  end
end