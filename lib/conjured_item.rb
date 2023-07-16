# frozen_string_literal: true

require_relative 'regular_item'

class ConjuredItem < RegularItem
  def update
    stay_one_day
    lose_quality(2) if quality.positive?
    lose_quality(2) if expired? && quality.positive?
  end
end
