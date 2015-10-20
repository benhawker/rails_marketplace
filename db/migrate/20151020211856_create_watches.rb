class CreateWatches < ActiveRecord::Migration
  def change
    create_table :watches do |t|

      t.timestamps null: false
    end
  end
end
