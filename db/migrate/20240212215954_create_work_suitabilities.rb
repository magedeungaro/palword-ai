class CreateWorkSuitabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :work_suitabilities do |t|
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
