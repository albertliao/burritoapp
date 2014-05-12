require 'spec_helper'

describe SessionsController do
  let! :user do
    User.create(:name => "Hannah",
      :email => "hannah@hannah.com",
      :password => "cheese")
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do

    describe "with email for non existant user" do
      let :session_params do
        {
          :email => "Awesome@nouser.com",
          :password => "cheese"
        }
      end

      it "should not login" do
        post :create, :session => session_params
        flash[:error].should =='Invalid email/password combination'      end
    end

    describe "with incorrect password" do
      let :session_params do
        {
          :email => "hannah@hannah.com",
          :password => "smelly cheese"
        }
      end

      it "should not login" do
        post :create, :session => session_params
        flash[:error].should == 'Invalid email/password combination'
      end
    end

    describe "with correct email/password" do
      let :session_params do
        {
          :email => "hannah@hannah.com",
          :password => "cheese"
        }
      end

      it "should save the user id in the session" do
        post :create, :session => session_params
        session[:remember_token].should == user.id
      end

      it "should set the current user" do
        post :create, :session => session_params
        assigns[:current_user].should == user
      end

      it "should redirect to root with success message" do
        post :create, :session => session_params
        response.should redirect_to(root_path)
      end

    end
  end

  describe "DELETE 'destroy'" do
    before do
      session[:remember_token] = user.id
    end

    it "should sign out user and redirect to root" do
      delete :destroy
      response.should redirect_to(root_path)
      session.keys.should_not include(:remember_token)
    end
  end

end
