class CreateCustomFields < ActiveRecord::Migration
   def up
      create_table :custom_fields do |t|
         t.text :key
         t.text :value
         t.references :custom_fieldable, :polymorphic => true
         t.timestamps
      end
      execute "CREATE INDEX custom_fields_gin_key ON custom_fields (key)"
      execute "CREATE INDEX custom_fields_gin_value ON custom_fields (value)"
   end

   def down
      drop_table :custom_fields
      execute "DROP INDEX custom_fields_gin_key"
      execute "DROP INDEX custom_fields_gin_value"
   end
end
