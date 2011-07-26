class CreateQuestionnaires < ActiveRecord::Migration
  def self.up
    create_table :questionnaires do |t|
      t.string :name
      t.integer :facilitator_id

      t.timestamps
    end
  end

  def self.down
    drop_table :questionnaires
  end
end
