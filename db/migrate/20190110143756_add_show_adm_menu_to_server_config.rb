class AddShowAdmMenuToServerConfig < ActiveRecord::Migration[5.2]
  def change
    add_column :server_configs, :show_adm_menu, :string
  end
end
