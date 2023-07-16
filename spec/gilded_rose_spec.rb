
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


    it "didn't regressed" do
      expected = "spec/50_test_cases.txt"
      actual = "test.txt"

      expect(IO.read(actual)).to eq IO.read(expected)
    end
  end
end
