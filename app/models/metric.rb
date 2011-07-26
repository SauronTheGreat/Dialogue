class Metric < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :student_group_metrics, :class_name=>"StudentGroupMetric", :foreign_key => "metric_id"
end
