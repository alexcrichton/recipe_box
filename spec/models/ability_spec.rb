require 'spec_helper'
require 'cancan/matchers'

describe Ability do

  before :each do
    @user = Factory.create(:user)
    @user.stub(:friend_uids).and_return []
    @ability = Ability.new @user
  end

  it "allows a user to manage their own recipes" do
    recipe = Factory.create :recipe, :user => @user

    @ability.should be_able_to(:create, Recipe)
    @ability.should be_able_to(:manage, recipe)
  end

  it "does not allow a not logged in user to do anything" do
    @ability = Ability.new nil

    @ability.should_not be_able_to(:create, Recipe)
    @ability.should_not be_able_to(:read, Recipe)
  end

  it "does not allow a user to read a non-friends' recipes" do
    recipe = Factory.create :recipe, :user => Factory.create(:user)

    @ability.should_not be_able_to(:read, recipe)
  end

  it "allows a user to read a friends' recipe" do
    user2 = Factory.create(:user, :fb_uid => '1')
    @user.stub(:friend_uids).and_return [Hashie::Mash.new(:id => '1')]
    @user.friends(true) # reload the friends
    @ability = Ability.new @user

    recipe = Factory.create :recipe, :user => user2

    @ability.should be_able_to(:read, recipe)
  end

end
