require 'spec_helper'

describe Document do
  describe "Attributes" do
    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:document) }
    it { should allow_mass_assignment_of(:visibility) }
    it { should allow_mass_assignment_of(:description) }
  end

  describe "Validations" do
    subject { Factory(:document) }
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
    it { should have_attached_file(:document) }
    it { should validate_attachment_presence(:document) }
    it { should validate_attachment_size(:document).less_than(10.megabytes) }
    it "should allow valid values for visibility" do
      Document::VISIBILITY_OPTIONS.each do |v|
        should allow_value(v).for(:visibility)
      end
    end
    it { should_not allow_value("other").for(:visibility) }
    it { should_not validate_presence_of(:description) }
  end

  describe "Named Scopes" do
    before :each do
      @public_document = Factory :document, :visibility => 'public'
      @reporter_document = Factory :document, :visibility => 'reporters'
      @sysadmin_document = Factory :document, :visibility => 'sysadmins'
    end

    it 'returns public and reporter visible documents for reporter scope' do
      reporter_documents = Document.visible_to_reporters
      reporter_documents.size.should == 2
      reporter_documents.include?(@public_document).should be_true
      reporter_documents.include?(@reporter_document).should be_true
    end

    it 'returns only public documents for public scope' do
      public_documents = Document.visible_to_public
      public_documents.size.should == 1
      public_documents.include?(@public_document).should be_true
    end
  end
end