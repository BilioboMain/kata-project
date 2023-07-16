
require 'spec_helper'
require_relative '../lib/gilded_rose'

RSpec.describe GildedRose do
  before(:all) { `ruby texttest_fixture.rb 50 > test.txt` }
  after(:all)  { `rm test.txt` }

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "decreases item quality and sell in by 1 if it isn't pass or brie or sulfuras" do
      items = [Item.new("foo", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
      expect(items[0].quality).to eq 9
      expect(items[0].sell_in).to eq 9
    end

    it "increases item quality in by 2 and decreases sell by 1 in for Backstage passes with quality below 50" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[0].quality).to eq 12
      expect(items[0].sell_in).to eq 9
    end

    it "increases item quality and decreases sell in by 1 for Aged Brie item with quality below 50" do
      items = [Item.new("Aged Brie", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Aged Brie"
      expect(items[0].quality).to eq 11
      expect(items[0].sell_in).to eq 9
    end

    it "increases item quality by 3 and decreases sell in by 1 for Backstage passes item with quality below 50" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[0].quality).to eq 13
      expect(items[0].sell_in).to eq 4
    end

    it "decreases item quality and sell in by 1 if it isn't pass or brie or sulfuras with quality 50" do
      items = [Item.new("foo", 10, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
      expect(items[0].quality).to eq 49
      expect(items[0].sell_in).to eq 9
    end

    it "doesn't change item quality and decreases sell by 1 in for Backstage passes with quality 50" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq 9
    end

    it "doesn't change item quality and decreases sell in by 1 for Aged Brie item with quality 50" do
      items = [Item.new("Aged Brie", 10, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Aged Brie"
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq 9
    end

    it "doesn't change item quality and decreases sell in by 1 for Backstage passes item with quality 50" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq 4
    end

    it "doesn't change item quality and sell for Sulfuras, Hand of Ragnaros item with quality 50" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq 5
    end

    it "quality decreases 2x and for regular item with quality 50 and below but above 0" do
      items = [Item.new("foo", -1, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
      expect(items[0].quality).to eq 48
      expect(items[0].sell_in).to eq -2
    end

    it "quality doesnt go above 50 for brie" do
      items = [Item.new("Aged Brie", -1, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Aged Brie"
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq -2
    end

    it "quality doesnt go above 50 for brie" do
      items = [Item.new("Aged Brie", -1, 49)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Aged Brie"
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq -2
    end

    it "pass loses all quality if it is past due date" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 49)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[0].quality).to eq 0
      expect(items[0].sell_in).to eq -2
    end

    it "Sulfuras, Hand of Ragnaros doesn't lose quality and sell in after due date passing" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", -1, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq -1
    end

    it "Brie doesn't lose quality and sell in after due date passing" do
      items = [Item.new("Aged Brie", -1, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Aged Brie"
      expect(items[0].quality).to eq 12
      expect(items[0].sell_in).to eq -2
    end

    it "Brie doesn't lose quality and sell in after due date passing" do
      items = [Item.new("Aged Brie", -1, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Aged Brie"
      expect(items[0].quality).to eq 50
      expect(items[0].sell_in).to eq -2
    end
=begin

    it "didn't regressed" do
      expected = "spec/50_test_cases.txt"
      actual = "test.txt"

      expect(IO.read(actual)).to eq IO.read(expected)
    end
=end
  end
end
