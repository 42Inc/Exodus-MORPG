class AddCountToQuest < ActiveRecord::Migration[5.2]
  def change
    add_column :quests, :count, :string
  end
end
