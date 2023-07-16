# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/gilded_rose'
require_relative '../lib/item'

# i decided to do refactoring with TDD, so started from covering everything with tests

RSpec.describe GildedRose do
  before(:all) { `ruby texttest_fixture.rb 50 > test.txt` }
  after(:all)  { `rm test.txt` }

  describe '#update_quality_regular_item' do
    it 'does not change the name' do
      items = [RegularItem.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    it "decreases item quality and sell in by 1 if it isn't pass or brie or sulfuras" do
      items = [RegularItem.new('foo', 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
      expect(items[0].quality).to eq 9
      expect(items[0].sell_in).to eq 9
    end

    it "decreases item quality and sell in by 1 if it isn't pass or brie or sulfuras with quality 50" do
      items = [RegularItem.new('foo', 10, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
      expect(items[0].quality).to eq 49
      expect(items[0].sell_in).to eq 9
    end

    it 'quality decreases 2x and for regular item with quality 50 and below but above 0' do
      items = [RegularItem.new('foo', -1, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
      expect(items[0].quality).to eq 48
      expect(items[0].sell_in).to eq(-2)
    end
  end
  describe '#update_quality_backstage_pass' do
    it 'increases item quality in by 2 and decreases sell by 1 in for Backstage passes with quality below 50' do
      items = [BackStagePass.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[0].quality).to eq 12
      expect(items[0].sell_in).to eq 9
    end

    it 'increases item quality by 3 and decreases sell in by 1 for Backstage passes item with quality below 50' do
      items = [BackStagePass.new('Backstage passes to a TAFKAL80ETC concert', 5, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[0].quality).to eq 13
      expect(items[0].sell_in).to eq 4
    end

    it "doesn't change item quality and decreases sell by 1 in for Backstage passes with quality 50" do
      items = [BackStagePass.new('Backstage passes to a TAFKAL80ETC concert', 10, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq 9
    end

    it "doesn't change item quality and decreases sell in by 1 for Backstage passes item with quality 50" do
      items = [BackStagePass.new('Backstage passes to a TAFKAL80ETC concert', 5, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq 4
    end

    it 'pass loses all quality if it is past due date' do
      items = [BackStagePass.new('Backstage passes to a TAFKAL80ETC concert', -1, 49)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[0].quality).to eq 0
      expect(items[0].sell_in).to eq(-2)
    end
  end
  describe '#update_quality_aged_brie' do
    it 'increases item quality and decreases sell in by 1 for Aged Brie item with quality below 50' do
      items = [AgedBrie.new('Aged Brie', 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Aged Brie'
      expect(items[0].quality).to eq 11
      expect(items[0].sell_in).to eq 9
    end

    it "doesn't change item quality and decreases sell in by 1 for Aged Brie item with quality 50" do
      items = [AgedBrie.new('Aged Brie', 10, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Aged Brie'
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq 9
    end

    it 'quality doesnt go above 50 for brie' do
      items = [AgedBrie.new('Aged Brie', -1, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Aged Brie'
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq(-2)
    end

    it 'quality doesnt go above 50 for brie' do
      items = [AgedBrie.new('Aged Brie', -1, 49)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Aged Brie'
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq(-2)
    end

    it "Brie doesn't lose quality and sell in after due date passing" do
      items = [AgedBrie.new('Aged Brie', -1, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Aged Brie'
      expect(items[0].quality).to eq 12
      expect(items[0].sell_in).to eq(-2)
    end

    it "Brie doesn't lose quality and sell in after due date passing" do
      items = [AgedBrie.new('Aged Brie', -1, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Aged Brie'
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq(-2)
    end

    it 'returns string with all attributes' do
      items = [AgedBrie.new('Aged Brie', -1, 50)]
      expect(items[0].to_s).to eq 'Aged Brie, -1, 50'
    end
  end
  describe '#update_quality_sulfuras' do
    it "doesn't change item quality and sell for Sulfuras, Hand of Ragnaros item with quality 50" do
      items = [Sulfuras.new('Sulfuras, Hand of Ragnaros', 5, 80)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Sulfuras, Hand of Ragnaros'
      expect(items[0].quality).to eq 80
      expect(items[0].sell_in).to eq 5
    end

    it "Sulfuras, Hand of Ragnaros doesn't lose quality and sell in after due date passing" do
      items = [Sulfuras.new('Sulfuras, Hand of Ragnaros', -1, 80)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Sulfuras, Hand of Ragnaros'
      expect(items[0].quality).to eq 80
      expect(items[0].sell_in).to eq(-1)
    end
  end

  describe '#update_quality_conjured_item' do
    it "Brie doesn't lose quality and sell in after due date passing" do
      items = [ConjuredItem.new('Conjured Item', 2, 8)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Conjured Item'
      expect(items[0].quality).to eq 6
      expect(items[0].sell_in).to eq 1
    end
  end
  describe '#update_quality_regression' do
    it "didn't regressed" do
      expected = 'spec/50_test_cases.txt'
      actual = 'test.txt'

      expect(IO.read(actual)).to eq IO.read(expected)
    end
  end
end
