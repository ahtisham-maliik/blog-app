class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :created_by
      t.string :member

      t.timestamps
    end
  end
end
