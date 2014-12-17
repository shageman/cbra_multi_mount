class CreateAdminThings < ActiveRecord::Migration
  def change
    create_table :admin_things do |t|
      t.string :name

      t.timestamps
    end
  end
end
