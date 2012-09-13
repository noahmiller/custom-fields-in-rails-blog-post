class CustomField < ActiveRecord::Base
  attr_accessible :key, :value
  belongs_to :custom_fieldable, :polymorphic => true
end
