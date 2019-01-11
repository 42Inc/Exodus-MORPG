class AddStatsToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :hp, :string
    add_column :players, :money, :string
  end
end
