require 'rails_helper' 


RSpec.describe "EventAttendance Model Tests", type: :model  do
  subject { EventAttendance.new }
  

  describe "associations" do
    it { should belong_to(:event_attendee).class_name('User') }
    it { should belong_to(:attended_event).class_name('Event') }

  end

end
