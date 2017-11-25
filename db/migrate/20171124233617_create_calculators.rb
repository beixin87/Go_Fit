class CreateCalculators < ActiveRecord::Migration
  def change
    create_table :calculators do |t|
      t.integer :calories
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
