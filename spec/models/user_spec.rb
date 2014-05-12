require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should respond_to(:password_digest) }

  it { should respond_to(:password) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  it "password should not persist" do
    @user.save
    @found_user = User.find_by(email: @user.email)
    @found_user.password.should_not be_present
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it "should authenticate and return the user" do
        found_user.authenticate(@user.password).should == found_user
      end
    end

    describe "with invalid password" do
      it "should not authenticate" do
        found_user.authenticate("invalid").should be_false
      end
    end
  end
end