require 'spec_helper'

describe Reports::ResponsesController do
  context "as a visitor" do
    describe "it should be protected" do
      before :each do get :overview, :id => 1 end
      it { should redirect_to(root_url) }
      it { should set_the_flash.to("You must be logged in to access this page") }
    end
  end

  context "as a reporter" do
    before :each do
      @req = Factory :data_request
      @reporter = Factory :reporter
      login @reporter
    end

    it "should render index" do
      get :overview, :id => @reporter.current_response.id
      response.should be_success
      assigns[:response].should == @reporter.current_response
    end

    it "should initialize an org report presenter" do
      get :overview, :id => @reporter.current_response.id
      assigns[:report].should_not be_nil
    end
  end
end