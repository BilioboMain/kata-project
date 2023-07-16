# frozen_string_literal: true

require_relative 'regular_item'

class BackStagePass < RegularItem
  def update
    stay_one_day
    return self.quality = 0 if expired?

    acquire_quality if quality_below_fifty?
    acquire_quality if sell_in < 10 && quality_below_fifty?
    acquire_quality if sell_in < 5 && quality_below_fifty?
  end
end
