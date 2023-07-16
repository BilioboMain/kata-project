# frozen_string_literal: true

require_relative 'regular_item'

class AgedBrie < RegularItem
  def update
    stay_one_day

    acquire_quality if quality_below_fifty?
    acquire_quality if sell_in.negative? && quality_below_fifty?
  end
end
