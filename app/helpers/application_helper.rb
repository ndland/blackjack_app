module ApplicationHelper

# The purpose of this method is
# to search to see if the current_user currently
# has any existing games in the game_list table

# Try to get game_list id of the game that has the same table id and user id as passed in
# if it comes up null then create game and return id
# then return string /game/id

  def link_to_game(user, table)

    current_game = GameList.find(:first, conditions: { user_id: user.id, table_id: table.id })

    return link_to_if(current_game.nil?, "#{table.name}", new_game_path(table: table.id)) do
      link_to table.name, game_path("#{current_game.id}")
    end
  end
end
