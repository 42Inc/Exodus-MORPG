class AddNameQuestToQuest < ActiveRecord::Migration[5.2]
  def change
    add_column :quests, :name_quest, :string
  end
end
