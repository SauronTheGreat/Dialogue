class User < ActiveRecord::Base
  belongs_to :facilitator_group, :class_name=>"FacilitatorGroup", :foreign_key => "facilitator_group_id"
  has_many :players, :class_name=>"Player", :foreign_key => "user_id"
  has_many :student_group_users, :class_name=> 'StudentGroupUser', :foreign_key => "user_id"
  has_many :questionnaires,:dependent => :destroy

    
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :registerable, :authenticatable, :recoverable,
    :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :facilitator_group_id, :first_name, :last_name, :identifier, :email, :password, :password_confirmation, :username, :admin, :educator
end
