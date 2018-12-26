require "yaml"

class QuestController < ApplicationController
  public
    def initialize
      @eventList = YAML.load_file('db/quests.yml')
      @events_menu_variable = 0
      @event_count = 8
      @print_action_index = Array.new(@event_count).map!{Array.new(2)}
      @print_action_count = 0;
      @accept_event_index = -1
      parser
    end

    def parser
      statesSamples = ['name', 'HP', 'DMG', 'ARM', 'MP', 'ST', 'San', 'Cash']
      @actionsList = Array.new(@event_count).map!{Array.new(6)}
      counter_i = 0
      counter_j = 0
      cnt = 0
      for counter_i in 0..(@event_count - 1)
        for counter_j in 0..5
          if @eventList[counter_i][statesSamples[counter_j]] != nil
            @actionsList[counter_i][counter_j] = @eventList[counter_i][statesSamples[counter_j]]
          end
        end
      end
      print_system("Triggering events...\n")
    end

    def get_event_for_hero(hero)
      loop do
        print_events_for_hero(hero)
        @events_menu_variable = STDIN.gets.chomp!
        if (@events_menu_variable != "")
          if (@events_menu_variable != "0" && @events_menu_variable.to_i == 0)
            @events_menu_variable = -2
          else
            @events_menu_variable = @events_menu_variable.to_i - 1
          end
        else
          @events_menu_variable = -2
        end

      break if (test_events_menu_variable() != -1)
        system "clear"
        set_color("error")
        STDOUT.print "[ERROR]  Incorrect option! Try again...\n\n"
        set_color("default")
      end

      system "clear"

      if (@accept_event_index == -1)
        case @events_menu_variable
          when -1
            system "clear"
            print_system("Exit game...\n")
          when @print_action_count
            system "clear"
            print_system("Saving game...\n")
          when @print_action_count + 1
            system "clear"
            print_system("Loading game...\n")
            hero.load_hero('saves/stats.yml')
          else
            print_error("Method get_event_for_hero() -> switch-case error!\n")
        end
      else
       @events_menu_variable = accept_event_for_hero(hero)
      end
      return @events_menu_variable
    end

    def print_events_for_hero(hero)
      STDOUT.print("Select\n")
      STDOUT.print("Quit game: [0]\n")
      @print_action_count = 0
      offset = 0
      for counter_i in 0..(@event_count - 1)
        if (!((@actionsList[counter_i][0] == "Go to the mines") && hero.mp < 50 && hero.san < 10))
          STDOUT.print("Event available: [" + (counter_i + 1 - offset).to_s  + "] "  + @actionsList[counter_i][0] + "\n")
          @print_action_index[counter_i][0] = counter_i - offset
          @print_action_index[counter_i][1] = counter_i
          @print_action_count = @print_action_count + 1
        else
          @print_action_index[counter_i][0] = -1
          @print_action_index[counter_i][1] = counter_i
          offset = offset + 1
        end
      end

      STDOUT.print("Save game: [" + (@event_count - offset + 1).to_s + "]\n")
      STDOUT.print("Load game: [" + (@event_count - offset + 2).to_s + "]\n")
    end

    def test_events_menu_variable()
      @accept_event_index = -1
      result = 0
      if (((@event_count + 2) < (@events_menu_variable + 1)) || ((@events_menu_variable + 1) < 0))
        result = -1
      end

      for counter_i in 0..(@event_count - 1)
        if (@print_action_index[counter_i][0] == @events_menu_variable && result == 0 && @events_menu_variable >= 0)
          @accept_event_index = @print_action_index[counter_i][1]
        end
      end
      return result
    end

    def accept_event_for_hero(hero)
      game_over = 0
      accept_error = 0
      old_hp = hero.hp
      old_mp = hero.mp
      old_st = hero.st
      old_san = hero.san
      old_cash = hero.cash

      if (@actionsList[@accept_event_index][1] != nil)
        hero.hp = hero.hp + @actionsList[@accept_event_index][1].to_i
        hero.hp = hero.hp > 100 ? 100 : hero.hp
        unless hero.hp > 0
          print_error_msg("WASTED!\n")
          accept_error = 1
          game_over = -2
        else
          hero.hp = hero.hp
        end
      end
      if (@actionsList[@accept_event_index][2] != nil)
        hero.mp = hero.mp + @actionsList[@accept_event_index][2].to_i
        hero.mp = hero.mp > 100 ? 100 : hero.mp
        unless hero.mp > 0
          print_error_msg("Not enough mana!\n")
          accept_error = 1
        else
          hero.mp = hero.mp
        end
      end
      if (@actionsList[@accept_event_index][3] != nil)
        hero.st = hero.st + @actionsList[@accept_event_index][3].to_i
        hero.st = hero.st > 100 ? 100 : hero.st
        unless hero.st > 0
          print_error_msg("Not allowed\n")
          accept_error = 1
        else
          hero.st = hero.st
        end
      end
      if (@actionsList[@accept_event_index][4] != nil)
        hero.san = hero.san + @actionsList[@accept_event_index][4].to_i
        hero.san = hero.san > 10 ? 10 : hero.san
        unless hero.san > -10
          hero.san = -10
          print_error_msg("Your hero just commited suicide!\n")
          game_over = -2
        else
          hero.san = hero.san
        end
      end
      if (@actionsList[@accept_event_index][5] != nil)
        hero.cash = hero.cash + @actionsList[@accept_event_index][5].to_i
        if (hero.cash < 0)
          accept_error = 1
          print_error_msg("Nischebrod!\n")
        end
      end

      if (@actionsList[@accept_event_index][0] == "Have some sleep")
        if (old_mp < 30)
          hero.hp = hero.hp + 90;
          hero.hp = hero.hp > 100 ? 100 : hero.hp
        end
        if (old_mp > 70)
          hero.san = hero.san - 3
          unless hero.san > -10
            hero.san = -10
            print_error_msg("Your hero just commited suicide!\n")
            game_over = -2
          else
            hero.san = hero.san
          end
        end
      end

      if (accept_error == 1)
        hero.hp = old_hp
        hero.mp = old_mp
        hero.st = old_st
        hero.san = old_san
        hero.cash = old_cash
      end
      return game_over
    end
end
