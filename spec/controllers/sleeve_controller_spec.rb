require 'spec_helper'

describe SleeveController do

  describe "creating a sleeve" do

    it "has a create sleeve method" do
      subject.create_sleeve
    end

    it "creates a sleeve of 312 cards" do
      subject.create_sleeve
      @sleeve.length.should eq(312)
    end
  end
end
