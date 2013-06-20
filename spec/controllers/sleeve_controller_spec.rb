require 'spec_helper'

describe SleeveController do

  describe "creating a sleeve" do

    it "has a create sleeve method" do
      subject.create_sleeve
    end

    it "creates a sleeve of 312 cards" do
      subject.create_sleeve
      Sleeve.count.should eq(312)
    end

    it "deletes the previous sleeve" do
      subject.create_sleeve
      subject.create_sleeve
      Sleeve.count.should eq(312)
    end

    it "sets the cardUsed to false" do
      subject.create_sleeve
      Sleeve.first.cardUsed.should eq(false)
    end

    it "has an ace of hearts" do
      subject.create_sleeve
      @card = Sleeve.find(:first, conditions: {suit: "H", faceValue: "A"})
      @card.should_not eq nil
    end

    it "only has 6 aces of hearts" do
      subject.create_sleeve
      @card = Sleeve.find(:all, conditions: {suit: "H", faceValue: "A"})
      @card.length.should eq (6)
    end
  end

  describe "getting a card" do
    it "creates a sleeve if there isn't already a sleeve" do
      subject.get_card
      Sleeve.count.should eq(312);
    end

    it "returns a card" do
      subject.create_sleeve
      @returned_card = subject.get_card
      @returned_card.should_not eq nil
    end

    it "changes the value of cardUsed to true" do
      @card = subject.get_card
      @card.cardUsed.should eq true
    end

    it "gets the first card whos cardUsed value is false" do
      @card1 = subject.get_card
      p @card1
      @card2 = subject.get_card
      p @card2
      @card1.should_not eq @card2
    end
  end
end
