class CreatePalWorkSuitabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :pal_work_suitabilities do |t|
      t.integer :level
      t.references :pal, null: false, foreign_key: true
      t.references :work_suitability, null: false, foreign_key: true

      t.timestamps
    end
  end
end
