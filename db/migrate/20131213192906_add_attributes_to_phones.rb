class AddAttributesToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :network_id, :integer
  end
end
