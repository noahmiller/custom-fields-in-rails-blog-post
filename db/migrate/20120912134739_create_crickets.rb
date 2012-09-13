class CreateCrickets < ActiveRecord::Migration
  def change
    create_table :crickets do |t|
      t.text :name
      t.timestamps
    end
  end
end
