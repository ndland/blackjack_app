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

    it "has a 10 of clubs" do
      subject.create_sleeve
      @card = Card.find(:first, conditions: {suit: "C", faceValue: "10"})
      @card.should_not eq nil
    end
  end

  describe "create_cards_if_needed" do

    it "has a method create_cards_if_needed" do
      subject.create_cards_if_needed
    end

    it "calls create_sleeve if there are no cards" do
      subject.create_cards_if_needed
      Card.count.should eq(312)
    end
  end

  describe "shuffling the deck" do

    it "has a shuffle deck function" do
      subject.shuffle
    end

    it "sets the cardUsed to false" do
      subject.shuffle
      Card.first.cardUsed.should eq(false)
    end

    it "sets an order to the cards" do
      subject.shuffle
      Card.first.order.should_not eq nil
    end

    it "gives each card a unique order number" do
      subject.shuffle
      @card1 = Card.find(:first)
      @card2 = Card.find(:first, conditions: { id: (@card1.id + 1) })
      @card1.order.should_not eq @card2.order
    end

    it "should be shuffled" do
      subject.shuffle
      @card1 = Card.find(:first)
      @card2 = Card.find(:first, conditions: { id: (@card1.id + 1) })
      @card2.order.should_not eq (@card1.order - 1)
    end
  end

  describe "getting a card" do

    it "has a get_card method" do
      subject.get_card
    end

    it "creates a sleeve if there isn't already a sleeve" do
      subject.get_card
      Card.count.should eq(312);
    end

    it "returns a card" do
      @returned_card = subject.get_card
      @returned_card.should_not eq nil
    end

    it "changes the value of cardUsed to true" do
      @card = subject.get_card
      @card.cardUsed.should eq true
    end

    it "gets a card that hasnt been used"  do
      @sleeve = Array.new(311)

      @sleeve.each do |card|
        Card.create(cardUsed: true)
      end

      @card = Fabricate(:card)

      @card2 = subject.get_card
      @card.suit.should eq @card2.suit
    end

    it "gets the lowest ordered unused card" do
      @sleeve = Array.new(310)

      @sleeve.each do |card|
        Card.create(cardUsed: true)
      end

      Fabricate(:card, order: 9)

      @wantedCard = Fabricate(:card, order: 3)
      @card2 = subject.get_card
      @card2.order.should eq @wantedCard.order
    end
  end

  it "should reset the sleeve when all the cards are used" do
    @sleeve = Array.new(312)

    @sleeve.each do |card|
      Card.create(cardUsed: true)
    end

    @card = subject.get_card
    @card.order.should_not eq nil
  end
end
