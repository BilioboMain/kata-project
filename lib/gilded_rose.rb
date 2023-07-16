# frozen_string_literal: true

require 'byebug'
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        item.update
      when 'Backstage passes to a TAFKAL80ETC concert'
        update_backstage_pass(item)
      when 'Sulfuras, Hand of Ragnaros'
        next
      else
        item.update
      end
    end
  end

  private

  def update_aged_brie(item)
    item.sell_in -= 1

    item.quality += 1 if item.quality < 50
    item.quality += 1 if item.sell_in.negative? && (item.quality < 50)
  end

  def update_backstage_pass(item)
    item.sell_in -= 1
    return item.quality = 0 if item.sell_in.negative?

    item.quality += 1 if item.quality < 50
    item.quality += 1 if item.sell_in < 10 && (item.quality < 50)
    item.quality += 1 if item.sell_in < 5 && (item.quality < 50)
  end
end
