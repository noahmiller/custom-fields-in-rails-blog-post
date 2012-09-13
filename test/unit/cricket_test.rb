require 'test_helper'

class CricketTest < ActiveSupport::TestCase
   def setup
      @cricket = Cricket.new(name: 'Carl')
      @cricket.parts.new(key: 'arms', value: '2')
      @cricket.parts.new(key: 'wings', value: 'lightweight')
      @cricket.save
   end

   test "reading cricket parts" do
      @cricket.reload
      assert_equal '2', @cricket.part(:arms)
   end

   test "updating cricket parts" do
      assert @cricket.part :arms, 4
      @cricket.save
      @cricket.reload
      assert_equal '4', @cricket.part(:arms)
   end

   test "searching on cricket parts existence" do
      # Because of the table alias (aliasing custom_fields as parts),
      # the join and where methods take different table names
      assert_equal @cricket, Cricket.joins(:parts).where(custom_fields: {key: 'arms'}).first
   end

   test "searching on cricket parts by value" do
      assert_equal @cricket,
       Cricket.joins(:parts).where(custom_fields: {key: 'arms', value: '2'}).first
      assert_equal 0,
       Cricket.joins(:parts).where(custom_fields: {key: 'arms', value: '57'}).length
   end

   test "searching on cricket parts by partial value" do
      assert_equal @cricket,
       Cricket.joins(:parts)
       .where("custom_fields.key = :key AND custom_fields.value LIKE :value",
         key: 'wings', value: '%wei%')
       .first
   end

   test "deleting all instances of a cricket part" do
      assert @cricket.reload.part :arms
      CustomField.find_by_custom_fieldable_type_and_key('Cricket', 'arms').destroy
      assert_nil @cricket.reload.part :arms
   end
end
