# frozen_string_literal: true

require_relative 'item'
require_relative 'regular_item'
require_relative 'sulfuras_item'
require_relative 'conjured_item'
require_relative 'backstage_item'
require_relative 'aged_brie_item'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each(&:update)
  end
end
