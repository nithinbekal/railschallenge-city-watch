class AddEmergencyReferenceToResponder < ActiveRecord::Migration
  def change
    change_table :responders do |t|
      t.references :emergency
    end
  end
end
