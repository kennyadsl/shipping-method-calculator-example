# frozen_string_literal: true

class AmazingStore::Calculator::Shipping::WeightShippingCalculator < Spree::ShippingCalculator
  preference :multiplier, :decimal, default: 1

  def self.description
    "Shipping Calculator based on package weight"
  end

  def compute_package(package)
    # Add your logic here.
    #
    # This sample one will just return the weight of the package's
    # items multiplied by a number that can be set in the admin panel.
    #
    package.contents.sum { |content| content.variant.weight } * preferred_multiplier
  end
end
