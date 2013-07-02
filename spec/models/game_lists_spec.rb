require 'spec_helper'

describe "Game Lists" do

  before { @game_list = GameList.new(table_id: 0, user_id: 1) }

  subject { @game_list }

  describe "when a game doesn't exist" do

    it { should be_valid }
  end

  describe "when a game already exists" do

    before { game_exists = @game_list.dup
      game_exists.save }

      it { should_not be_valid }
  end

  describe "when a user has the Intermediate table session open" do

    before { other_game = GameList.new(table_id: 1, user_id: 1).save }

    it { should be_valid }
  end
end
