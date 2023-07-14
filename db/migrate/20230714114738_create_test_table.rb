class CreateTestTable < ActiveRecord::Migration[7.0]
  def change
    create_table :test_tables do |t|

      t.timestamps
    end
  end
end
