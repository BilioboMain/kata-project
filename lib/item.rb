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
    self.sell_in -= 1
    self.quality -= 1 if quality.positive?
    self.quality -= 1 if self.sell_in.negative? && self.quality.positive?
  end
end

class AgedBrie < RegularItem
  def update
    self.sell_in -= 1

    self.quality += 1 if self.quality < 50
    self.quality += 1 if self.sell_in.negative? && (self.quality < 50)
  end
end

class BackStagePass < RegularItem
  def update
    self.sell_in -= 1
    return self.quality = 0 if self.sell_in.negative?

    self.quality += 1 if self.quality < 50
    self.quality += 1 if self.sell_in < 10 && (self.quality < 50)
    self.quality += 1 if self.sell_in < 5 && (self.quality < 50)
  end
end
