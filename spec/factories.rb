FactoryGirl.define do
	factory :user do
		name "Mikael Theimer"
		email "mikaeltheim@gmail.com"
		password "foobar"
		password_confirmation "foobar"
	end
end