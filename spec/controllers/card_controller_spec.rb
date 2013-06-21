require 'spec_helper'

describe CardController do

  describe "creating a sleeve" do

    it "has a create sleeve method" do
      subject.create_sleeve
    end

    it "creates a sleeve of 312 cards" do
      subject.create_sleeve
      Card.count.should eq(312)
    end

    it "deletes the previous sleeve" do
      subject.create_sleeve
      subject.create_sleeve
      Card.count.should eq(312)
    end

    it "has an ace of hearts" do
      subject.create_sleeve
      @card = Card.find(:first, conditions: {suit: "H", faceValue: "A"})
      @card.should_not eq nil
    end

    it "only has 6 aces of hearts" do
      subject.create_sleeve
      @card = Card.find(:all, conditions: {suit: "H", faceValue: "A"})
      @card.length.should eq (6)
    end

    it "calls the shuffle function" do
      subject.create_sleeve
      @card = Card.first
      @card.cardUsed.should_not eq nil
    end
  end

  describe "shuffling the deck" do
    it "has a shuffle deck function" do
      subject.shuffle
    end

    it "sets the cardUsed to false" do
      subject.create_sleeve
      Card.first.cardUsed.should eq(false)
    end

    it "sets a order to the cards" do
      subject.create_sleeve
      Card.first.order.should_not eq nil
    end

    it "gives each card a unique order number" do
      subject.create_sleeve
      @card1 = Card.find(:first)
      @card2 = Card.find(:first, conditions: { id: (@card1.id + 1) })
      @card1.order.should_not eq @card2.order
    end

    it "should be shuffled" do
      subject.create_sleeve
      @card1 = Card.find(:first)
      @card2 = Card.find(:first, conditions: { id: (@card1.id + 1) })
      @card2.order.should_not eq (@card1.order - 1)
    end
  end

  # describe "getting a card" do
  #   it "creates a sleeve if there isn't already a sleeve" do
  #     subject.get_card
  #     Card.count.should eq(312);
  #   end

  #   it "returns a card" do
  #     subject.create_sleeve
  #     @returned_card = subject.get_card
  #     @returned_card.should_not eq nil
  #   end

  #   it "changes the value of cardUsed to true" do
  #     @card = subject.get_card
  #     @card.cardUsed.should eq true
  #   end

  #   it "gets the first card whos cardUsed value is false" do
  #     @sleeve = Array.new(311)
  #     @sleeve.each do |card|
  #       Card.create(cardUsed: true)
  #     end
  #     @card = Fabricate(:sleeve)
  #     @card2 = subject.get_card
  #     @card.suit.should eq @card2.suit
  #   end

  #   it "should create a new sleeve when all the cards are used" do
  #     @sleeve = Array.new(312)
  #     @sleeve.each do |card|
  #       Card.create(cardUsed: true)
  #     end
  #     @card = subject.get_card
  #     @card.suit.should_not eq nil
  #   end
  # end
end
