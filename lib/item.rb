# frozen_string_literal: true

require 'byebug'
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

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

class AgedBrie < RegularItem
  def update
    stay_one_day

    acquire_quality if quality_below_fifty?
    acquire_quality if sell_in.negative? && quality_below_fifty?
  end
end

class BackStagePass < RegularItem
  def update
    stay_one_day
    return self.quality = 0 if expired?

    acquire_quality if quality_below_fifty?
    acquire_quality if sell_in < 10 && quality_below_fifty?
    acquire_quality if sell_in < 5 && quality_below_fifty?
  end
end

class Sulfuras < RegularItem
  def update; end
end

class ConjuredItem < RegularItem
  def update
    stay_one_day
    lose_quality(2) if quality.positive?
    lose_quality(2) if expired? && quality.positive?
  end
end
