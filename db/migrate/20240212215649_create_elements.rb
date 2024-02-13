# frozen_string_literal: true

class CreateElements < ActiveRecord::Migration[7.1]
  def change
    create_table :elements do |t|
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
