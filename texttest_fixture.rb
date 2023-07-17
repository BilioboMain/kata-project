#!/usr/bin/ruby -w
# frozen_string_literal: true

require_relative 'lib/gilded_rose'
require_relative 'lib/item'

puts 'OMGHAI!'
items = [
  RegularItem.new('+5 Dexterity Vest', 10, 20),
  AgedBrie.new('Aged Brie', 2, 0),
  RegularItem.new('Elixir of the Mongoose', 5, 7),
  Sulfuras.new('Sulfuras, Hand of Ragnaros', 0, 80),
  Sulfuras.new('Sulfuras, Hand of Ragnaros', -1, 80),
  BackStagePass.new('Backstage passes to a TAFKAL80ETC concert', 15, 20),
  BackStagePass.new('Backstage passes to a TAFKAL80ETC concert', 10, 49),
  BackStagePass.new('Backstage passes to a TAFKAL80ETC concert', 5, 49),
  ConjuredItem.new('Conjured Mana Cake', 3, 6)
]

days = 2
days = ARGV[0].to_i + 1 if ARGV.size.positive?

gilded_rose = GildedRose.new items
(0...days).each do |day|
  puts "-------- day #{day} --------"
  puts 'name, sellIn, quality'
  items.each do |item|
    puts item
  end
  puts ''
  gilded_rose.update_quality
end
