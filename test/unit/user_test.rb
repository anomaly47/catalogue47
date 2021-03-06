require 'test_helper'

class UserTest < ActiveSupport::TestCase

    should have_many(:user_friendships)
    should have_many(:friends)

	 test "a user should enter a first name" do  
	 	user = User.new
	 	assert !user.save
	 	assert !user.errors[:first_name].empty?
	 end

	 test "a user should enter a last name" do  
	 	user = User.new
	 	assert !user.save
	 	assert !user.errors[:last_name].empty?
	 end

	 test "a user should enter a profile name" do  
	 	user = User.new
	 	assert !user.save
	 	assert !user.errors[:profile_name].empty?
	 end
	 test "a user should have a unique profile name" do  
	 	user = User.new
	 	user.profile_name = users(:commander).profile_name

	 	assert !user.save
	 	assert !user.errors[:profile_name].empty?
	 end

	 test "a user should have a profile name without spaces" do 
	 	user = User.new(first_name: 'Meow', last_name: 'Cat', email: 'mewMew4u@meow.com')
	 	user.password = user.password_confirmation = 'catcatcat'
	 	
	 	user.profile_name = "My Profile With Spaces"

	 	assert !user.save
	 	assert !user.errors[:profile_name].empty?
	 	assert user.errors[:profile_name].include?("Must be formatted correctly.")

	 end

	 test "a user can have a correctly formatted profile name" do
	 	user = User.new(first_name: 'Meow', last_name: 'Cat', email: 'mewMew4u@meow.com')
	 	user.password = user.password_confirmation = 'catcatcat'

	 	user.profile_name = 'madameMeowington'
	 	assert user.valid? 

	 end

    test "that no error is raised when trying to access a friend list" do
      assert_nothing_raised do
        users(:commander).friends
      end
    end

    test "that creating friendships on a user works" do
    
        users(:commander).friends << users(:janeway)
        users(:commander).friends.reload
        assert users(:commander).friends.include?(users(:janeway))
    end
end
