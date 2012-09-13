class Cricket < ActiveRecord::Base
  attr_accessible :name
  has_many :parts, :as => :custom_fieldable, :autosave => true,
   :class_name => 'CustomField', :dependent => :destroy

   # Find a part in memory by key.
   # The speed of this method when there are large numbers of custom fields
   # could be increased by using a SQL lookup unless parts_changed?
   def part_record key
      parts.detect { |p| p.key == key }
   end

   # Set or get a part.
   #   o.part :arm, 2
   #   o.part :arm
   def part(*args)
      key, value = args
      key = key && key.to_s
      if args.size == 1
         p = part_record(key) and p.value
      elsif args.size == 2
         raise ArgumentError, "invalid key #{key.inspect}" unless key
         p = part_record(key) || self.parts.new(key: key)
         p.value = value
      else raise ArgumentError, "wrong number of arguments (#{args.size} for 1 or 2)"
      end
   end
end
