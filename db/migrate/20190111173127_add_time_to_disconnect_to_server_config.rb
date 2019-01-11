class AddTimeToDisconnectToServerConfig < ActiveRecord::Migration[5.2]
  def change
    add_column :server_configs, :time_to_disconnect, :string
  end
end
