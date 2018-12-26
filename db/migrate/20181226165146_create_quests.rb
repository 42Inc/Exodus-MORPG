class CreateQuests < ActiveRecord::Migration[5.2]
  def change
    create_table :quests do |t|
      t.string :id_user
      t.string :stage
      t.string :id_quest

      t.timestamps
    end
  end
end
