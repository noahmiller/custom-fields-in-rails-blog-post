class CreateHorseflies < ActiveRecord::Migration
   def up
      create_table :horseflies do |t|
         t.text :name
         t.hstore :parts
         t.timestamps
      end
      execute "CREATE INDEX horseflies_gin_parts ON horseflies USING GIN(parts)"
   end

   def down
      drop_table :horseflies
      execute "DROP INDEX horseflies_gin_parts"
   end
end
