module ApplicationHelper

# The purpose of this method is
# to search to see if the current_user currently
# has any existing games in the game_list table

# Try to get game_list id of the game that has the same table id and user id as passed in
# if it comes up null then create game and return id
# then return string /game/id

	def link_to_game(user, table)
    user_id = user.id
    puts user_id
		table_id = table.id
    puts table_id
    example = GameList.find(:first, :conditions => { :user_id => user_id, :table_id => table_id })
    puts example.id
  end
end
