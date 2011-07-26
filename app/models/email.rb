class Email < ActiveRecord::Base
  attr_accessible :player_id, :inout, :newreply, :to_players, :from_player, :subject, :mail_body
  belongs_to :player, :class_name=>"Player", :foreign_key => "player_id"
end
