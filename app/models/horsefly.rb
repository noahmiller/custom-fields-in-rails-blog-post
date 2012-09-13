class Horsefly < ActiveRecord::Base
   attr_accessible :name, :parts
   # Necessary for serializing parts as an hstore
   serialize :parts, ActiveRecord::Coders::Hstore

   # Set or get a part.
   #   o.part :arm, 2
   #   o.part :arm
   def part(*args)
      key, value = args
      key = key && key.to_s
      if args.size == 1
         parts && parts[key]
      elsif args.size == 2
         raise ArgumentError, "invalid key #{key.inspect}" unless key
         parts_will_change!
         self.parts = (parts || {}).merge(key => value)
         self.parts[key]
      else raise ArgumentError, "wrong number of arguments (#{args.size} for 1 or 2)"
      end
   end
end
