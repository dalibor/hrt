# encoding: UTF-8

require File.dirname(__FILE__) + '/../spec_helper'
require 'nokogiri'

describe ExcelXML do
  before :each do
    @excel_data = [
      ["Name:</Bad>", "Age:", "Favorite date:"],
      [ "Åke", 42.0, Date.new(1982, 2, 14) ],
      [ "Örjan", 33.0, Date.new(1933, 2, 14) ]
    ]
    @excel = ExcelXML.new("Sheetzor", @excel_data)
  end

  it 'should generate a correct header' do
    # pending 'depends on rails (Hash.from_xml), needs to be rewritten'
    expected_header = {
                         "xmlns:x"=>"urn:schemas-microsoft-com:office:excel",
                         "xmlns:ss"=>"urn:schemas-microsoft-com:office:spreadsheet",
                         "xmlns:html"=>"http://www.w3.org/TR/REC-html40",
                         "xmlns"=>"urn:schemas-microsoft-com:office:spreadsheet",
                         "xmlns:o"=>"urn:schemas-microsoft-com:office:office"
                      }

    @sheet = @excel.to_sheet
    workbook = Hash.from_xml(@sheet)
    workbook['Workbook']['xmlns:x'].should == expected_header['xmlns:x']
  end

  it "should contain the correct data" do
    @sheet = @excel.to_sheet
    doc = Nokogiri::XML(@sheet)
    doc.css("Workbook > Worksheet > Table > Row").each_with_index do |row, i|
      row.css('Cell').each_with_index do |cell, j|
        cell.content.strip.should == @excel_data[i][j].to_s
      end
    end
  end

  it 'should not HTML-encode åäö' do
    @sheet = @excel.to_sheet
    @sheet.should include('Åke')
    @sheet.should include('Örjan')
  end

  it 'should encode <>' do
    @sheet = @excel.to_sheet
    @sheet.should_not include('</Bad>')
    @sheet.should include('&lt;/Bad&gt;')
  end

  it 'should have the correct data types and styling' do
    @sheet = @excel.to_sheet
    doc = Nokogiri::XML(@sheet)
    doc.css("Workbook > Worksheet > Table > Row > Cell").each do |cell|
      data = cell.css('Data').first
      if found_content = @excel_data.flatten.find { |v| v.to_s == data.content }
        case found_content
        when Date
          data['Type'].should == 'Date'
        when Numeric
          data['Type'].should == 'Number'
          # cell['StyleID'].should be_nil
        when BigDecimal
          data['Type'].should == 'Number'
          # cell['StyleID'].should == 'currency'
        else
          data['Type'].should == 'String'
          # cell['StyleID'].should == 'string'
        end
      else
        raise "Did not find content for #{ data.content.inspect }"
      end
    end
  end
end

describe ExcelXML do
  it 'should write XML to an IO-object' do
    io = StringIO.new
    ExcelXML.build(io) do |excel|
      excel.worksheet "The Worksheet" do
        excel << [ "foo", "bar" ]
      end
    end
    io.string.should match(/^<Workbook/)
  end
end
