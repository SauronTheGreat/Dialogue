class Rule < ActiveRecord::Base
    attr_accessible :name, :description
    has_many :student_group_rules, :class_name=> 'StudentGroupRule', :foreign_key => "rule_id"

end
