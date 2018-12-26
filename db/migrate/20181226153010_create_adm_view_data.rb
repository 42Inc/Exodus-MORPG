class CreateAdmViewData < ActiveRecord::Migration[5.2]
  def change
    create_table :adm_view_data do |t|
      t.string :id_user
      t.string :view_list_adm_iframe_1
      t.string :view_location
      t.string :view_location_iframe
      t.string :view_user_adm_iframe_id_1
      t.string :view_list_game_iframe_1
      t.string :view_list

      t.timestamps
    end
  end
end
