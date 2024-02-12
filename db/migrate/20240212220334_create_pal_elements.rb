class CreatePalElements < ActiveRecord::Migration[7.1]
  def change
    create_table :pal_elements do |t|
      t.references :pal, null: false, foreign_key: true
      t.references :element, null: false, foreign_key: true

      t.timestamps
    end
  end
end
