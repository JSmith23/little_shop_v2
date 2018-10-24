class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :thumbnail
      t.decimal :price
      t.integer :inventory
      t.text :description
      t.boolean :enabled, default: true
      t.references :users, foreign_key: true

      t.timestamps
    end
  end
end
