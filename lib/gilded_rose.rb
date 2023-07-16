# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

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

  def update_regular(item)
    item.sell_in -= 1

    item.quality -= 1 if item.quality.positive?
    item.quality -= 1 if item.sell_in.negative? && item.quality.positive?
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        update_aged_brie(item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        update_backstage_pass(item)
      when 'Sulfuras, Hand of Ragnaros'
        next
      else
        update_regular(item)
      end
    end
  end
end
