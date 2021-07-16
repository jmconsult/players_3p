class PlayersController < ApplicationController

#     Alan Maciel
# 5:23 PM
# Programming Exercise
# We need to create players.
# The players have a name, health, and a power
# The name is created using the following 3 lists:
# First Name: Super, Ultra, omni, Bati, Mega, Aqua
# Middle Name: Chayote, Champiñon, Tomate, Colifor, Rabano
# Last Name: Vengador, Nocturno, de las sombras, Tronador, Indestructible
# The Health is a random numeric value between 25-75 given at player creation time.
# The Power is the same.
# The maximum value for both Health and Power are 100 and the minimum is 0 When a player has a Power of 100 he is Maxed Out!
# When a player Health reach 0 the player is Dead.
# Each player has the following methods: woot and blam
# woot increases the player power by 10 without breaking the 100 maxed out value blam decreases the player health by 10 without getting below dead level of 0.
# Each player can print his status to the screen like this:

# The <player's name> has a Health of X and a Power of Y the current status is <normal | maxed out | dead>.
# Alan Maciel
# 5:25 PM
# Task 1
# Create 10 players each with a random name using first, midddle and last names. a random health and power.

# Task 2
# Create a Tournament or Game in which the 10 players fight and dies until there is one champion.

    def index
        @players = Player.all.order('name')
    end

    # deletes all players and starts from scratch
    def new
        Player.delete_all
        for ii in 1..10
            player = Player.new
            player.save
        end
        @players = Player.all
        render 'index'
    end

    #starts the game, saves the state every time a player is dead
    #every state is going to be rendered at the view
    def play
        @states = []
        players = Player.all
        rounds = 0
        previous_dead_count = 0

        mapped_values = players.map{|p| {"name":p.name,"health":p.health,"power":p.power,"status":p.status,"color":p.color}}
        @states << { "players": mapped_values ,"dead_count": 0 , "round": 0}

        while true
            case rand(1..2)
            when 1 # woot
                players[rand(0..9)].woot
            when 2 # blam
                players[rand(0..9)].blam
            end
            rounds += 1
            total_dead = 0
            players.each do |player|
                total_dead += ( player.dead? ? 1 : 0)
            end
            if total_dead > previous_dead_count
                previous_dead_count = total_dead
                # when the number of dead players decreases, save the state
                mapped_values = players.map{|p| {"name":p.name,"health":p.health,"power":p.power,"status":p.status,"color":p.color}}
                @states << { "players": mapped_values ,"dead_count": total_dead , "round": rounds}
            end
            if total_dead > 8
                # breaks when only one is alive
                break 
            end
        end
        @winner = players.select{ |v| !v.dead? }[0]
        render 'game_stats'
    end


end
