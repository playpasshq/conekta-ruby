require 'spec_helper'

describe Conekta::LineItem do
  #include_context "API 1.1.0"
  before(:all) do
    Conekta.api_base    = "http://0.0.0.0:3000"
    Conekta.api_version = "1.1.0"
    Conekta.api_key     = "FAKIOXUSc4ca4238a0b9"
  end

  let(:line_items) do
    [{
       name: "Box of Cohiba S1s",
       description: "Imported From Mex.",
       unit_price: 35000,
       quantity: 1,
       tags: ["food", "mexican food"],
       type: "physical"
     },
     {
       name: "Other item",
       description: "other description",
       unit_price: 35000,
       quantity: 1,
       tags: ["food"],
       type: "physical"
     }]
  end
  let(:order_data) do
    {
      currency: 'mxn',
      line_items: line_items
    }
  end

  context "deleting line items" do
    it "successful line item delete" do
      order     = Conekta::Order.create(order_data)
      line_item = order.line_items.first

      line_item.delete

      expect(line_item.deleted).to eq(true)
    end
  end

  context "updating line items" do
    it "successful line item update" do
      order     = Conekta::Order.create(order_data)
      line_item = order.line_items.first

      line_item.update(unit_price: 1000)

      expect(line_item.unit_price).to eq(1000)
    end

    it "unsuccessful line item update" do
      expect {
        line_item.update(type: nil)
      }.to raise_error(Conekta::ParameterValidationError)
    end
  end

end
