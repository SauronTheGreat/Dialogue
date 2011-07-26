class Questionnaire < ActiveRecord::Base
  has_many :questions,:dependent => :destroy
  belongs_to :user

  validates_presence_of :user_id

end

