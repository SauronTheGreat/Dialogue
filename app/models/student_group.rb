class StudentGroup < ActiveRecord::Base
  attr_accessible :facilitator_group_id,:case_study_id, :facilitator, :name
  belongs_to :facilitator_group, :class_name=> 'FacilitatorGroup', :foreign_key => "facilitator_group_id"
  has_one :case_study, :class_name=> 'CaseStudy', :foreign_key => "case_study_id"
  has_many :games, :class_name=> 'Game', :foreign_key => "student_group_id"
  has_many :student_group_rules, :class_name=> 'StudentGroupRule', :foreign_key => "student_group_id"
  has_many :student_group_metrics, :class_name=> 'StudentGroupMetric', :foreign_key => "student_group_id"
  has_many :student_group_users, :class_name=> 'StudentGroupUser', :foreign_key => "student_group_id"
  has_many :players, :through=> :games
end
