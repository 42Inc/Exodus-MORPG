class AddTypeQuestToQuest < ActiveRecord::Migration[5.2]
  def change
    add_column :quests, :type_quest, :string
  end
end
