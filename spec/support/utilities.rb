include ApplicationHelper

def full_title(page_title)
	base_title = "Sample App"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}"
	end
end

# Pour définir un "have_error_message" qui cherche à chaque fois le bon div
RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		page.should have_selector('div.alert.alert-error', text: message)
	end
end

# Définition d'une fontion qui effectue un signin valide
def valid_signin(user)
	fill_in "Email", with: user.email
	fill_in "Password", with: user.password
	click_button "Sign in"
end
