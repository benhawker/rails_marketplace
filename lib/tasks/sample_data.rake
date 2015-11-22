namespace :db do
	desc "Fill db with sample data"
	task populate_users: :environment do
		100.times do
			name = Faker::Name.name
			email = Faker::Name.email
			password = "password"

			User.create! (name: name, 
										email: email, 
										password: password,
										password_confirmation: password)
		end						
	end 
end