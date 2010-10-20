# http://guides.rubyonrails.org/testing.html

require 'test_helper'

class QuotationTest < ActiveSupport::TestCase
  
  test "should not save quotation without quote" do
    quotation = Quotation.new
    assert !quotation.save, "Saved the quotation without a quote"
  end
  
  test "should not save quotation without category" do
    quotation = Quotation.new
    assert !quotation.save, "Saved the quotation without category"
  end
  
  test "valid quotation" do
    assert quotations(:valid_quotation_1).valid?, "Save valid"
    #assert quotations(:invalid_quotation_1).valid?, "Invalid"
  end
    
end
