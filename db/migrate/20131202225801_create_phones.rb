class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :ip
      t.string :net

      t.timestamps
    end
  end
end
