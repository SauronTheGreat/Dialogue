class Scoreq < ActiveRecord::Base
  attr_accessible :player_id, :student_group_metric_id, :value
  belongs_to :student_group_metric, :class_name=> 'StudentGroupMetric', :foreign_key => "student_group_metric_id"
  belongs_to :player, :class_name=> 'Player', :foreign_key => "player_id"


end
