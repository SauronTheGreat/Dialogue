class Briefing < ActiveRecord::Base
  attr_accessible :role_id, :briefing_note
  belongs_to :role, :class_name=>"Role", :foreign_key => "role_id"

end
