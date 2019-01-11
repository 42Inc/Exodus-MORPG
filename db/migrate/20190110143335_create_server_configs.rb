class CreateServerConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :server_configs do |t|
      t.boolean :permit_registration

      t.timestamps
    end
  end
end
