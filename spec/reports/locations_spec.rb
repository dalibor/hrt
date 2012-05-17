require File.dirname(__FILE__) + '/../spec_helper_lite'
$: << File.join(APP_ROOT, "app/reports")
require 'app/reports/locations'

describe Reports::Locations do
  let(:resource) { mock :resource }
  let(:splits) { mock :splits }
  let(:report) { Reports::Locations.new(resource) }

  it "finds the location splits for an activity" do
    resource.should_receive(:coding_spend_district).and_return splits
    report.splits(resource, :spend)
    resource.should_receive(:coding_budget_district).and_return splits
    report.splits(resource, :budget)
  end
end
