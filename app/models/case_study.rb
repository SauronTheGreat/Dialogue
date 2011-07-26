class CaseStudy < ActiveRecord::Base
  attr_accessible :name, :summary, :party_type, :game_type, :issue_type, :delivery_type, :eval_type ,:case_study_type
  has_many :issues, :class_name=>"Issue", :foreign_key => "case_study_id"
  has_many :roles, :class_name=>"Role", :foreign_key => "case_study_id"
  has_many :student_groups, :class_name=>"StudentGroup", :foreign_key => "case_study_id"
  has_many :games, :class_name=>"Game", :foreign_key => "case_study_id"
end
