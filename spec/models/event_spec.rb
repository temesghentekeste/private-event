require 'rails_helper' 


RSpec.describe "Event Model Tests", type: :model  do
  subject { Event.new }
  describe "validations" do
    it "should validate presence of title" do
      subject.description =  'Some description'
      expect(subject.valid?).to be false 
    end
    it { should validate_presence_of (:description) }
    it { should validate_presence_of (:start_datetime) }
    it { should validate_presence_of (:end_datetime) }

    it { is_expected.to validate_length_of(:title).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_length_of(:description).is_at_least(3).is_at_most(500) }

    it "should validate end datetime be after start datetime" do
      subject.start_datetime = Date.today+4.weeks+1.day 
      subject.end_datetime = Date.today

      subject.valid?

      expect(subject.errors[:end_datetime]).to eql(["cannot be before the start date"]) 

    end
    
  end

  describe "associations" do
    it { should belong_to(:creator).class_name('User') }
    it { should have_many(:event_attendances).class_name("EventAttendance") }
    it { should have_many(:event_attendees).through(:event_attendances) }
  end
end
