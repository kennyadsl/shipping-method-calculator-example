# frozen_string_literal: true

require 'solidus_starter_frontend_helper'

module AmazingStore::Calculator::Shipping
  RSpec.describe WeightShippingCalculator, type: :model do
    let(:line_item1) { build(:line_item, variant: create(:variant, weight: 2)) }
    let(:line_item2) { build(:line_item, variant: create(:variant, weight: 3)) }

    let(:inventory_unit1) { build(:inventory_unit, line_item: line_item1, variant: line_item1.variant) }
    let(:inventory_unit2) { build(:inventory_unit, line_item: line_item2, variant: line_item2.variant) }

    let(:package) do
      build(
        :stock_package,
        contents: [
          Spree::Stock::ContentItem.new(inventory_unit1),
          Spree::Stock::ContentItem.new(inventory_unit2),
        ]
      )
    end

    subject { described_class.new(preferred_multiplier: 2) }

    it "returns the total weight of the package's content multiplied by the preferred_multiplier" do
      expect(subject.compute(package)).to eq(10) # (2 + 3) * 2
    end

    it "returns a BigDecimal" do
      expect(subject.compute(package)).to be_a(BigDecimal)
    end
  end
end
