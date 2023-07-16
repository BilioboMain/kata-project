# frozen_string_literal: true

class RegularItem < Item
  def update
    stay_one_day
    lose_quality if quality.positive?
    lose_quality if expired? && quality.positive?
  end

  def quality_below_fifty?
    quality < 50
  end

  def stay_one_day
    self.sell_in -= 1
  end

  def lose_quality(step = 1)
    self.quality -= 1 * step
  end

  def acquire_quality
    self.quality += 1
  end

  def expired?
    sell_in.negative?
  end
end
