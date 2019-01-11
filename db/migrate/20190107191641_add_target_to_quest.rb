class AddTargetToQuest < ActiveRecord::Migration[5.2]
  def change
    add_column :quests, :target, :string
  end
end
