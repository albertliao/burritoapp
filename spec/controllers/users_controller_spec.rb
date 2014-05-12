require 'spec_helper'

describe UsersController do

  describe "GET new" do
    it "should succeed" do
      get :new
      response.should be_success
    end

    it "should assign a new user" do
      get :new
      assigns[:user].should be_a(User)
      assigns[:user].should_not be_persisted
    end
  end

  describe "POST create" do
    let :user_params do
      {
      :name => "Awesome McAwesome",
      :email => "awesome@awesomesauce.com",
      :password => "awesomesecret"
      }
    end

    it "should redirect to root" do
      post :create, :user => user_params
      response.should redirect_to(root_path)
    end

    it "should create a user" do
      expect do
        post :create, :user => user_params
      end.to change{User.count}.by(1)
    end
  end
end
