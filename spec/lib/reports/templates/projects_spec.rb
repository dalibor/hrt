require 'spec_helper'

describe Reports::Templates::Projects do
  it "returns template" do
    report = Reports::Templates::Projects.new('csv').data
    FileParser.parse(report, 'csv')[0].should ==
      Reports::Detailed::ProjectsExport::FILE_UPLOAD_COLUMNS
  end
end
