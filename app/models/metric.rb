class Metric < ActiveRecord::Base

  #Relationships
  attr_accessible :name, :description
  has_many :student_group_metrics, :class_name=>"StudentGroupMetric", :foreign_key => "metric_id"

  #Validations
  validates_presence_of :name
  validates_presence_of :student_group_metrics

end
