require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  before :each do
    @user = Factory.create(:user)
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
end
