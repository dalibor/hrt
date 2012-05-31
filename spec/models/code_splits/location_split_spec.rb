require File.dirname(__FILE__) + '/../../spec_helper'

# All logic specific to InputSplit type assignments
describe LocationSplit do
  describe "named scopes" do
    before :each do
      basic_setup_project
      activity = Factory.create(:activity, :data_response => @response, :project => @project)

      code1    = Factory.create(:location, :short_display => 'code1')
      code2    = Factory.create(:location, :short_display => 'code2')
      code11   = Factory.create(:location, :short_display => 'code11', :parent => code1)
      code21   = Factory.create(:location, :short_display => 'code21', :parent => code2)

      @cs1      = Factory.create(:location_spend_split, :activity => activity, :code => code1)
      @cs2      = Factory.create(:location_spend_split, :activity => activity, :code => code2)
      @cs11     = Factory.create(:location_spend_split, :activity => activity, :code => code11)
      @cs21     = Factory.create(:location_spend_split, :activity => activity, :code => code21)

      @ca1      = Factory.create(:location_budget_split, :activity => activity, :code => code1)
      @ca2      = Factory.create(:location_budget_split, :activity => activity, :code => code2)
      @ca11     = Factory.create(:location_budget_split, :activity => activity, :code => code11)
      @ca21     = Factory.create(:location_budget_split, :activity => activity, :code => code21)
    end

    it "#roots" do
      LocationSpendSplit.roots.should == [@cs1, @cs2]
      LocationBudgetSplit.roots.should == [@ca1, @ca2]
    end
  end
end