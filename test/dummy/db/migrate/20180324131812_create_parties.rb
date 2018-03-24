class CreateParties < ActiveRecord::Migration[5.1]
  def change
    create_table :parties do |t|
      t.references :event, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
