class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :thumbnail, default: "https://www.riobeauty.co.uk/images/product_image_not_found_thumb.gif"
      t.decimal :price
      t.integer :inventory
      t.text :description
      t.boolean :enabled, default: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
