require 'test_helper'

class HorseflyTest < ActiveSupport::TestCase
   def setup
      @horsefly = Horsefly.new(name: 'Harry', parts: { arms: 2, wings: :lightweight })
      @horsefly.save
   end

   test "reading horsefly parts" do
      @horsefly.reload
      assert_equal '2', @horsefly.part(:arms)
   end

   test "updating horsefly parts" do
      assert @horsefly.part :arms, 4
      @horsefly.save
      @horsefly.reload
      assert_equal '4', @horsefly.part(:arms)
   end

   test "searching on horsefly parts existence" do
      assert_equal @horsefly, Horsefly.where("parts ? :key", key: 'arms').first
   end

   test "searching on horsefly parts by value" do
      # The @> search operator makes use of the GIN index
      assert_equal @horsefly,
       Horsefly.where("parts @> (:key => :value)", key: 'arms', value: '2').first
      assert_equal 0,
       Horsefly.where("parts @> (:key => :value)", key: 'arms', value: '57').count
   end

   test "searching on horsefly parts by partial value" do
      # The LIKE operator does not use the GIN index, so this search would
      # benefit from another manner of indexing
      assert_equal @horsefly,
       Horsefly.where("parts -> :key LIKE :value", key: 'wings', value: "%wei%").first
   end

   test "deleting all instances of a horsefly part" do
      assert @horsefly.reload.part :arms
      Horsefly.delete_key(:parts, :arms)
      assert_nil @horsefly.reload.part :arms
   end
end
