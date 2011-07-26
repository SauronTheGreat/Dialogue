class StudentRouting < ActiveRecord::Base
  attr_accessible :planning_required,:pre_neg_required,:post_neg_required,:pre_neg_taken,:post_neg_taken
end
